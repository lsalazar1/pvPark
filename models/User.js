const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
    name: {
        type: String,
        trim: true,
        required: true    
    },
    email: {
        type: "String",
        unique: true,
        required: true
    },
    password: {
        type: String,
        required: true
    },
    dateRegistered: {
        type: Date,
        default: Date.now
    }
});

module.exports = User = mongoose.model('user', UserSchema);