const mongoose = require('mongoose');

const SrCollinsSchema = new mongoose.Schema({
    lotName: {
        default: "SR Collins",
        type: String
    },
    sensors: [
        { _id: String , isVacant: Boolean }
    ]
});

module.exports = Srcollins = mongoose.model('srcollins', SrCollinsSchema);