const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
    name: {
        type: String,
        trim: true,
        required: true    
    },
    email: {
        type: String,
        trim: true,
        unique: true,
        required: true
    },
    username: {
        required: true,
        type: String,
        unique: true,
    },
    password: {
        type: String,
        trim: true,
        required: true
    },
    dateRegistered: {
        type: Date,
        default: Date.now
    }
});

module.exports = User = mongoose.model('user', UserSchema);