const express = require('express');
const router = express.Router();

const BusinessAG = require("../../models/BusinessAG")

let data = {
    'lotName': 'businessag',
    'sensors': [
        {
            '_id': 'bus0',
            'isVacant': true
        },
        {
            '_id': 'bus1',
            'isVacant': false
        },
        {
            '_id': 'bus2',
            'isVacant': false
        },
        {
            '_id': 'bus3',
            'isVacant': false
        },
        {
            '_id': 'bus4',
            'isVacant': true
        },
        {
            '_id': 'bus5',
            'isVacant': false
        },
        {
            '_id': 'bus6',
            'isVacant': true
        },
        {
            '_id': 'bus7',
            'isVacant': true
        },
        {
            '_id': 'bus8',
            'isVacant': true
        },
        {
            '_id': 'bus9',
            'isVacant': true
        },
    ]
}

router.get("/", async (req, res) => {
    //de-structuring
    let {lotName, sensors} = data
    
    let lot = await BusinessAG.findOne()
    if (!lot) {
        let newLot = new BusinessAG({lotName, sensors})
        await newLot.save()
    }

    try {
        lot = await BusinessAG.findOne()
        res.send(lot)
    } catch (error) {
        res.status(500).json({"msg": "error 500"})
    }
})

module.exports = router