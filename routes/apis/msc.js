const express = require('express');
const router = express.Router();

const MSC = require("../../models/MSC")

let data = {
    'lotName': 'memorial student center',
    'sensors': [
        {
            '_id': 'msc0',
            'isVacant': true
        },
        {
            '_id': 'msc1',
            'isVacant': true
        },
        {
            '_id': 'msc2',
            'isVacant': false
        },
        {
            '_id': 'msc3',
            'isVacant': false
        },
        {
            '_id': 'msc4',
            'isVacant': true
        },
        {
            '_id': 'msc5',
            'isVacant': false
        },
        {
            '_id': 'msc6',
            'isVacant': true
        },
        {
            '_id': 'msc7',
            'isVacant': false
        },
        {
            '_id': 'msc8',
            'isVacant': true
        },
        {
            '_id': 'msc9',
            'isVacant': false
        },
        {
            '_id': 'msc10',
            'isVacant': true
        },
        {
            '_id': 'msc11',
            'isVacant': true
        },
        {
            '_id': 'msc12',
            'isVacant': false
        },
        {
            '_id': 'msc13',
            'isVacant': false
        },
        {
            '_id': 'msc14',
            'isVacant': true
        },
        {
            '_id': 'msc15',
            'isVacant': false
        },
        {
            '_id': 'msc16',
            'isVacant': true
        },
        {
            '_id': 'msc17',
            'isVacant': false
        },
        {
            '_id': 'msc18',
            'isVacant': true
        },
        {
            '_id': 'msc19',
            'isVacant': false
        },
        {
            '_id': 'msc20',
            'isVacant': true
        },
        {
            '_id': 'msc21',
            'isVacant': true
        },
        {
            '_id': 'msc22',
            'isVacant': true
        },
        {
            '_id': 'msc23',
            'isVacant': false
        },
        {
            '_id': 'msc24',
            'isVacant': true
        },
        {
            '_id': 'msc25',
            'isVacant': false
        },
        {
            '_id': 'msc26',
            'isVacant': false
        },
        {
            '_id': 'msc27',
            'isVacant': false
        },
        {
            '_id': 'msc28',
            'isVacant': true
        },
        {
            '_id': 'msc29',
            'isVacant': false
        },
        {
            '_id': 'msc30',
            'isVacant': true
        },
        {
            '_id': 'msc31',
            'isVacant': true
        },
        {
            '_id': 'msc32',
            'isVacant': true
        },
        {
            '_id': 'msc33',
            'isVacant': false
        },
        {
            '_id': 'msc34',
            'isVacant': true
        },
        {
            '_id': 'msc35',
            'isVacant': false
        },
        {
            '_id': 'msc36',
            'isVacant': false
        },
        {
            '_id': 'msc37',
            'isVacant': false
        },
        {
            '_id': 'msc38',
            'isVacant': true
        },
        {
            '_id': 'msc39',
            'isVacant': false
        },
    ]
}

router.get("/", async (req, res) => {
    //de-structuring
    let {lotName, sensors} = data
    
    let lot = await MSC.findOne()
    if (!lot) {
        let newLot = new MSC({lotName, sensors})
        await newLot.save()
    }

    try {
        lot = await MSC.findOne()
        res.send(lot)
    } catch (error) {
        res.status(500).json({"msg": "error 500"})
    }
})

module.exports = router