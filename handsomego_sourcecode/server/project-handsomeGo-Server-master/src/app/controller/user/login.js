const express = require('express');
const router = express.Router();
const db = require('../../module/pool.js');
const jwt = require('../../module/jwt.js');

router.post('/', async (req, res, next) => {

    const kakaoId = req.body.id;
    const name = req.body.name;
    const profileImagePath = req.body.profileImagePath;

    const checkToekn = 'SELECT * FROM writer WHERE writer_token = ?'
    const insertUser = 'INSERT INTO writer(writer_name, writer_token, writer_pic) VALUES (?, ?, ?)'
    const defaultStamp = 'INSERT INTO stamp(place_id, writer_id) VALUES (?, ?)'

    let token;

    let checkToeknData = await db.execute2(checkToekn, kakaoId);

    if (!checkToeknData) {
        res.status(500).send({
            message: "Internel Server Error",
            data: null
        })
    }
    else {
        //이미 가입 처리
        if (checkToeknData.length == 1) {
            token = jwt.sign(checkToeknData[0].writer_id);
        }
        //처음 이용
        else {
            let insertUserData = await db.execute4(insertUser, name, kakaoId, profileImagePath);
            for(i = 1; i < 21; i++) {
                await db.execute4(defaultStamp, i, insertUserData.insertId);
            }
            token = jwt.sign(insertUserData.insertId);
        }
        res.status(200).send({
            message: 'login success',
            token: token
        });
    }

});

module.exports = router;
