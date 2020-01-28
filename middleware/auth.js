// Import these modules or libraries
const jwt = require('jsonwebtoken');
const config = require('config');

module.exports = function(req, res, next) {
    // Get the token from request's header
    const token = req.header('x-auth-token');

    // If no token exists, return JSON with error message
    if (!token) {
        return res.status(401).json({ msg: 'No token, auth denied' });
    }

    try {
        const decoded = jwt.verify(token, config.get('jwtToken'));
        
        req.user = decoded.user;
        next();
    } catch (err) {
        res.status(401).json({ msg: 'Token is not valid' })
    }
}

