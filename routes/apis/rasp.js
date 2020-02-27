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
    try {
        let lot = await SrCollins.findOne();
        res.send(lot);
    } catch (err) {
        res.status(500).json({'msg' : 'Error 500'});
        console.error(err.message);
    }
});

module.exports = router;