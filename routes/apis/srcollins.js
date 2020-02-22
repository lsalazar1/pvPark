const express = require('express');
const router = express.Router();

const auth = require('../../middleware/auth');
const SrCollins = require('../../models/SrCollins');

// @route       api/srcollins
// @desc        GET SR Collins JSON
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