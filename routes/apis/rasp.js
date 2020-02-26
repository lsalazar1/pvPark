//

const express = require('express');
const router = express.Router();

// Bring this in later
const auth = require('../../middleware/auth');
const Rasp = require('../../models/Rasp');

let data = {
    'lotName': 'rasp',
    'sensors': [
        {
            '_id': 'ras0',
            'isVacant': false
        },
        {
            '_id': 'ras1',
            'isVacant': false
        },
        {
            '_id': 'ras2',
            'isVacant': false
        },
        {
            '_id': 'ras3',
            'isVacant': false
        },
        {
            '_id': 'ras4',
            'isVacant': true
        },
        {
            '_id': 'ras5',
            'isVacant': true
        },
        {
            '_id': 'ras6',
            'isVacant': false
        },
        {
            '_id': 'ras7',
            'isVacant': false
        },
        {
            '_id': 'ras8',
            'isVacant': true
        },
        {
            '_id': 'ras9',
            'isVacant': true
        },
    ]
};

// @route       api/rasp
// @desc        GET rasp JSON
// @access      PRIVATE
router.get('/', async (req, res) => {
    // Destructure fields in data JSON above...
    let {lotName, sensors} = data;

    // Returns a document in the newscience collection...
    let lot = await Rasp.findOne();
    
    // If there are no documents in the collection, this if-statement will create a lot object with the destructured fields in line 22
    if (!lot) {
        let newLot = new Rasp({lotName, sensors});
        await newLot.save()     // Saves the new lotObj to the db
    }

    // Will return a document from the newscience collection as a response... Otherwise there may be some problem reaching the server
    try {
        lot = await Rasp.findOne();
        res.send(lot);
    } catch (error) {
        // Returns a 500 Status Code and a json
        res.status(500).json({'msg': 'Error 500'})
    }
});

module.exports = router;