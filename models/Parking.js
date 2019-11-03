const mongoose = require('mongoose');

const ParkingSchema = new mongoose.Schema({
    lotName: {
        type: String,
    },
    sensors:[
        {
            sensorID: {
                type: String,
            },
            vacant: {
                type: Boolean,
                default: false
            },
            date: {
                type: Date,
                default: Date.now
            }
        }
    ]
});