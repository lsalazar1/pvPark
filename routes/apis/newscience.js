const express = require('express');
const router = express.Router();

// Bring this in later
const auth = require('../../middleware/auth');
const NewScience = require('../../models/NewScience');

// @route       api/newscience
// @desc        GET New Science JSON
// @access      PRIVATE
router.get('/', async (req, res) => {
    let data = {
        'lotName': 'newscience',
        'sensors': [
            {
                '_id': 'new0',
                'isVacant': true
            }
        ]
    };

    // Destructure fields in data JSON above...
    let {lotName, sensors} = data;

    // Returns a document in the newscience collection...
    let lot = await NewScience.findOne();
    
    // If there are no documents in the collection, this if-statement will create a lot object with the destructured fields in line 22
    if (!lot) {
        let newLot = new NewScience({lotName, sensors});
        await newLot.save()     // Saves the new lotObj to the db
    }


    // Will return a document from the newscience collection as a response... Otherwise there may be some problem reaching the server
    try {
        lot = await NewScience.findOne();
        res.send(lot);
    } catch (error) {
        // Returns a 500 Status Code and a json
        res.status(500).json({'msg': 'Error 500'})
    }
});

module.exports = router;