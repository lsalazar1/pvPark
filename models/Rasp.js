
const mongoose = require('mongoose');

// Delete this comment later
const RaspSchema = new mongoose.Schema({
    lotName: {
        default: "Rasp",
        type: String
    },
    sensors: [
        { _id: String , isVacant: Boolean }
    ]
});

module.exports = Newscience = mongoose.model('Rasp', RaspSchema);