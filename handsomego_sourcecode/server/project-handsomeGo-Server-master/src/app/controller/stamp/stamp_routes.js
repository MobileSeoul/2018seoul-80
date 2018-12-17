const express = require('express');
const router = express.Router();

//장소
const stamp = require('./stamp');
router.use('/stamps', stamp);

module.exports = router;
