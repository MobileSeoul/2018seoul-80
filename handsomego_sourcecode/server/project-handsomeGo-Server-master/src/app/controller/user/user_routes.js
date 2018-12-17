const express = require('express');
const router = express.Router();

//login
const login = require('./login');
router.use('/login', login);

//마이페이지
const myPage = require('./myPage');
router.use('/mypage', myPage);

module.exports = router;
