const mongoose = require("mongoose")
const MSCSchema = new mongoose.Schema({
    lotName: {
        default: "Memorial Student Center",
        type: String
    },
    sensors: [
        {_id: String, isVacant: Boolean}
    ]

})

module.exports = Msc = mongoose.model("msc", MSCSchema)