const express = require('express');
const bcrypt = require('bcryptjs');
const router = express.Router();
const { check, validationResult } = require('express-validator');

const User = require('../../models/User');

// @route   POST api/users
// @desc    Register a user
// @access  Public
router.post(
    '/', 
    [
        check('name', 'Name is required')
            .not()
            .isEmpty(),
        check('email', 'Please use your PV email')
            .contains('pvamu.edu'),
        check('password', 'Please enter a password with 8 or more characters')
            .isLength({ min: 8 })    
    ],
    async (req, res) => {
        const errors = validationResult(req);

        // If there are any errors found by validationResult in user's HTTP request, we'll return an HTTP status code 400
        // with an array of errors found
        if (!errors.isEmpty()) {
            return res.status(400).json({ errors: errors.array() });
        }

        // Destruct the body of the request and get these values
        const { name, email, password } = req.body;

        try {
            // Using the user's email value in the request's body, find if it exists in the database... Returns a query
            let user = await User.findOne({ email });


            if (user) {
                return res.status(400).json({ errors: [{ msg: 'User already exists' }] });
            }

            // Create User object and assign it to user variable
            user = new User({
                name,
                email,
                password
            });

            const salt = await bcrypt.genSalt(10);

            user.password = await bcrypt.hash(password, salt);

            await user.save();

            res.send('User registered');
        } catch (err) {
            console.error(err.message);
            res.status(500).send('Server Error');
        }
        
        res.send('User Route');
    }
);

module.exports = router;