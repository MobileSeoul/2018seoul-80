const express = require('express');
const router = express.Router();

//장소
const place = require('./place');
router.use('/places', place);

module.exports = router;
