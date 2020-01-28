const express = require('express');
const router = express.Router();
const auth = require('../../middleware/auth');
const config = require('config');
const { check, validationResult } = require('express-validator');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const User = require('../../models/User');

// @route    GET api/auth
// @desc     Test route
// @access   Public
router.get('/', auth, async (req, res) => {
    try {
        const user = await User.findById(req.user.id).select('-password');
        res.json(user);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

// @route       POST api/auth
// @desc        Authenticate the user and get-token
// @access      Public
router.post(
    '/',
    [
        check('email', 'Please use your PV Email').contains('pvamu.edu'),
        check('password', 'Password is required').exists()
    ],
    async (req, res) => {
        const errors = validationResult(req);

        // If errors object is not empty...
        if (!errors.isEmpty()) {
            return res.status(400).json({ errors: errors.array() });
        }

        // Destructure body of req to get email and pass...
        const { email, password } = req.body;

        try {
            // Sees if user exists...
            let user = await User.findOne({ email })

            if (!user) {
                return res.status(400).json({ errors: [{ msg: 'Invalid credentials'}] });
            }

            // Comapres req's pass and pass in database
            const isMatch = await bcrypt.compare(password, user.password);

            if (!isMatch) {
                return res.status(400).json({ msg: 'Invalid credentials' });
            }

            // Create the payload
            const payload = {
                user: {
                    id: user.id
                }
            }

            jwt.sign(
                payload,
                config.get('jwtToken'),
                { expiresIn: 86400 },
                (err, token) => {
                    if (err) throw err;
                    res.json({ token })
                });
        } catch (err) {
            console.error(err.message);
            res.status(500).send('Server Error');
        }
    }
);

module.exports = router;