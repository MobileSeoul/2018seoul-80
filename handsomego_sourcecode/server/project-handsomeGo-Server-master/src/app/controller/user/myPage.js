const express = require('express');
const router = express.Router();
const jwt = require('../../module/jwt.js');
const pool = require('../../module/pool.js');
const upload = require('../../../config/multer');

let multiUpload = upload.fields(
    [
        {
            name: 'picture'
        }
    ]
);

router.get('/', async (req, res, next) => {

    const ID = jwt.verify(req.headers.authorization);

    const getMyPageQuery = 'SELECT * FROM writer WHERE writer_id = ?';
    const getMyStampQuery = 'SELECT * FROM stamp WHERE writer_id = ? AND stamp_status = 1 ORDER BY stamp_date DESC';

    if (ID != -1) {
        let getMyPage = await pool.execute2(getMyPageQuery, ID);
        let getMyStamp = await pool.execute2(getMyStampQuery, ID);

        let object = {};

        object.name = getMyPage[0].writer_name;
        object.picture = getMyPage[0].writer_pic;
        object.stampCount = getMyStamp.length;
        object.lastStampDate = getMyStamp[0].stamp_date;

        if (!getMyPage || !getMyStamp) {
            res.status(500).send({
                message: "Internel Server Error",
                data: null
            })
        }
        else {
            if (getMyPage.length == 0 || getMyStamp.length == 0) {
                res.status(404).send({
                    message: "Not Found User Data",
                    data: null
                });
            } else {
                res.status(200).send({
                    message: "Successful Get User Data",
                    data: object
                });
            }

        }
    }
    else {
        res.status(401).send({
            message: "access denied",
            data: null
        });
    }

});

router.put('/', multiUpload, async (req, res, next) => {

    const ID = jwt.verify(req.headers.authorization);

    const getMyPageQuery = 'SELECT * FROM writer WHERE writer_id = ?';
    const updateMyPageQuery = 'UPDATE writer SET ? WHERE writer_id = ?'

    if (ID != -1) {

        let getMyPage = await pool.execute2(getMyPageQuery, ID);

        if (!getMyPage) {
            res.status(500).send({
                message: "Internel Server Error",
                data: null
            })
        }
        else {

            let name = req.body.name

            if (!name) {
                name = getMyPage[0].writer_name;
            }

            let data = {
                writer_name : name,
                writer_pic : req.files.picture ? req.files.picture[0].location : getMyPage[0].writer_pic
            };
            
            let getMyStamp = await pool.execute3(updateMyPageQuery, data, ID);
            
            if (getMyStamp.length == 0) {
                res.status(404).send({
                    message: "Fail Update User",
                    data: null
                });
            } else {
                getMyPage = await pool.execute2(getMyPageQuery, ID);
                res.status(200).send({
                    message: "Successful Update User",
                    data: getMyPage
                });
            }
        }

    }
    else {
        res.status(401).send({
            message: "access denied",
            data: null
        });
    }

});

module.exports = router;
