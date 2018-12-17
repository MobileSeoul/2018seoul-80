const express = require('express');
const router = express.Router();

//댓글
const comment = require('./comment');
router.use('/comments', comment);

module.exports = router;
