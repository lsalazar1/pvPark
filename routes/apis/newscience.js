const express = require('express');
const router = express.Router();

const auth = require('../../middleware/auth');
const NewScience = require('../../models/NewScience');

// @route       api/newscience
// @desc        GET New Science lot JSON
// @access      PRIVATE
router.get('/', async (req, res) => {
    try {
        let lot = await NewScience.findOne();
        res.send(lot);
    } catch (err) {
        res.status(500).json({'msg' : 'Error 500'});
        console.error(err.message);
    }
});

module.exports = router;