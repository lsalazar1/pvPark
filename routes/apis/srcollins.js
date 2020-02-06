const express = require('express');
const router = express.Router();

const auth = require('../../middleware/auth');

// @route       api/srcollins
// @desc        GET api/srcollins
// @access      PRIVATE
router.get('/', async (req, res) => {
    try{
        // This variable is a sample object of what the full app would have 
        const srcollins = {
            "lotName" : "SRCollins",
            "sensors" : [
                { "_id" : "SRC0", "isVacant" : true },
                { "_id" : "SRC0", "isVacant" : true },
                { "_id" : "SRC0", "isVacant" : true },
                { "_id" : "SRC0", "isVacant" : true },
                { "_id" : "SRC0", "isVacant" : true }
            ]
        }

        // Send JSON object as a successful response
        res.send(srcollins);
    } catch (err) {
        res.status(500).json({'msg' : 'Error 500'});
        console.error(err.message);
    }
});

module.exports = router;