const express = require('express');
const router = express.Router();

//랭크
const rank = require('./rank');
router.use('/ranks', rank);

module.exports = router;
