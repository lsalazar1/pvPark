const mongoose = require("mongoose");

const BusinessAGSchema = new mongoose.Schema({
    lotName: {
        default: "Business AG",
        type: String
    },
    sensors: [
        { _id: String , isVacant: Boolean }
    ]
});

module.exports = Businessag = mongoose.model("businessag", BusinessAGSchema);