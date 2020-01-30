const express = require('express');
const bcrypt = require('bcryptjs');
const router = express.Router();
const { check, validationResult } = require('express-validator');

const User = require('../../models/User');

// @route   POST api/users/
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
            .isLength({ min: 8 }),
        check('username', 'Username needs to have more than 4 characters')
            .isLength({ min: 5 })    
    ],
    async (req, res) => {
        const errors = validationResult(req);

        // If there are any errors found by validationResult in user's HTTP request, we'll return an HTTP status code 400
        // with an array of errors found
        if (!errors.isEmpty()) {
            return res.status(400).json({ errors: errors.array() });
        }

        // Destruct the body of the request and get these values
        const { name, email, password, username } = req.body;

        try {
            // Using the user's email value in the request's body, find if it exists in the database... Returns a query
            let user = await User.findOne({ email });

            // If user does exist, return with error status 400 and json
            if (user) {
                return res.status(400).json({ errors: [{ msg: 'User already exists' }] });
            }

            // Create User object and assign it to user variable
            user = new User({
                name,
                email,
                password,
                username
            });

            const salt = await bcrypt.genSalt(10);

            // Hash user's password
            user.password = await bcrypt.hash(password, salt);

            // Save onto database
            await user.save();

            res.send('User registered');
        } catch (err) {
            console.error(err.message);
            res.status(500).send('Server Error');
        }
    }
);

module.exports = router;