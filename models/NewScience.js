const mongoose = require('mongoose');

// Delete this comment later
const NewScienceSchema = new mongoose.Schema({
    lotName: {
        default: "New Science",
        type: String
    },
    sensors: [
        { _id: String , isVacant: Boolean }
    ]
});

module.exports = Newscience = mongoose.model('newscience', NewScienceSchema);