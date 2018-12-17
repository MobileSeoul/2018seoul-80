const express = require('express');
const router = express.Router();
const jwt = require('../../module/jwt.js');
const pool = require('../../module/pool.js');
const upload = require('../../../config/multer');

let multiUpload = upload.fields(
    [
        {
            name: 'pictures'
        }
    ]
);

//댓글 세부 조회
router.get('/:comment_id', async (req, res) => {

    const comment_id = req.params.comment_id;

    const getCommentQuery = 'SELECT w.writer_name, c.* FROM comment c JOIN writer w ON c.writer_id = w.writer_id WHERE c.comment_id = ?';

    const getCommentInfo = await pool.execute2(getCommentQuery, comment_id);

    if (!getCommentInfo) {
        res.status(500).send({
            message: "Internel Server Error",
            data: null
        })
    }
    else {
        if (getCommentInfo.length == 0) {
            res.status(404).send({
                message: "Not Found Comment Data",
                data: null
            });
        } else {
            res.status(200).send({
                message: "Successful Get Comment Data",
                data: getCommentInfo
            });
        }
    }

});

//댓글 작성
router.post('/', multiUpload, async (req, res) => {

    const ID = jwt.verify(req.headers.authorization);

    const insertCommentQuery = 'INSERT INTO comment SET ?'
    const getMyCommentQuery = 'SELECT * FROM comment WHERE writer_id = ? AND place_id = ?'
    const getSumStarAndConnemtCountQuery = 'SELECT star_sum, comment_count FROM place WHERE place_id = ?'
    const updateSumStarAndCommentCountQuery = 'UPDATE place SET ? WHERE place_id = ?'

    let data = {};

    if (ID != -1) {

        let getMyComment = await pool.execute3(getMyCommentQuery, ID, req.body.place_id);

        if (getMyComment.length == 1) {
            res.status(200).send({
                message: "Already Post Comment",
                data: null
            })
        }
        else {
            data.writer_id = ID;
            data.place_id = req.body.place_id;
            data.comment_star = req.body.star;
            data.comment_comment = req.body.comments;
            data.comment_date = new Date();

            if (req.files.pictures === undefined) {
                data.comment_pic1 = null;
                data.comment_pic2 = null;
                data.comment_pic3 = null;
                data.comment_pic4 = null;
            } else {
                if (req.files.pictures.length == 1) {
                    data.comment_pic1 = req.files.pictures[0].location ? req.files.pictures[0].location : null;
                }
                else if (req.files.pictures.length == 2) {
                    data.comment_pic1 = req.files.pictures[0].location ? req.files.pictures[0].location : null;
                    data.comment_pic2 = req.files.pictures[1].location ? req.files.pictures[1].location : null;
                }
                else if (req.files.pictures.length == 3) {
                    data.comment_pic1 = req.files.pictures[0].location ? req.files.pictures[0].location : null;
                    data.comment_pic2 = req.files.pictures[1].location ? req.files.pictures[1].location : null;
                    data.comment_pic3 = req.files.pictures[2].location ? req.files.pictures[2].location : null;
                }
                else {
                    data.comment_pic1 = req.files.pictures[0].location ? req.files.pictures[0].location : null;
                    data.comment_pic2 = req.files.pictures[1].location ? req.files.pictures[1].location : null;
                    data.comment_pic3 = req.files.pictures[2].location ? req.files.pictures[2].location : null;
                    data.comment_pic4 = req.files.pictures[3].location ? req.files.pictures[3].location : null;
                }
            }

            //댓글 작성
            const result = await pool.execute2(insertCommentQuery, data);

            //현재까지 총점과 댓글 수
            const lastStarSum = await pool.execute2(getSumStarAndConnemtCountQuery, req.body.place_id);

            //총점
            const nowStarSum = parseFloat(lastStarSum[0].star_sum) + parseFloat(req.body.star);
            //댓글 수
            const nowCommentCount = parseInt(lastStarSum[0].comment_count) + parseInt(1);

            let data2 = {
                star_sum: nowStarSum,
                comment_count: nowCommentCount,
                place_star: (nowStarSum / nowCommentCount).toFixed(1)
            };

            //총점 반영
            const result2 = await pool.execute3(updateSumStarAndCommentCountQuery, data2, req.body.place_id);

            if (!result || !result2) {
                res.status(500).send({
                    message: "Internel Server Error",
                    data: null
                })
            }
            else {
                res.status(201).send({
                    message: "Successful Post Comment",
                    data: null
                })
            }
        }
    } else {
        res.status(403).send({
            message: 'Access Denied'
        });
    }
});

//댓글 삭제
router.delete('/:comment_id', async (req, res) => {

    const ID = jwt.verify(req.headers.authorization);

    const comment_id = req.params.comment_id;

    const getCommentQuery = 'SELECT * FROM comment WHERE comment_id = ? AND writer_id = ?';
    const deleteCommentQuery = 'DELETE FROM comment WHERE comment_id = ?'

    const getSumStarAndConnemtCountQuery = 'SELECT star_sum, comment_count FROM place WHERE place_id = ?'
    const updateSumStarAndCommentCountQuery = 'UPDATE place SET ? WHERE place_id = ?'

    if (ID != -1) {

        const getComment = await pool.execute3(getCommentQuery, comment_id, ID);

        if (!getComment) {
            res.status(500).send({
                message: "Internel Server Error",
                data: null
            })
        }
        else {
            if (getComment.length == 1) {

                const star = getComment[0].comment_star;
                const place_id = getComment[0].place_id;

                //댓글 삭제
                const result = await pool.execute2(deleteCommentQuery, comment_id);

                //현재까지 총점과 댓글 수
                const lastStarSum = await pool.execute2(getSumStarAndConnemtCountQuery, place_id);

                //총점
                const nowStarSum = parseFloat(lastStarSum[0].star_sum) - parseFloat(star);
                //댓글 수
                const nowCommentCount = parseInt(lastStarSum[0].comment_count) - parseInt(1);

                let data2 = {
                    star_sum: nowStarSum,
                    comment_count: nowCommentCount,
                    place_star: (nowStarSum / nowCommentCount).toFixed(1)
                };

                //총점 반영
                const result2 = await pool.execute3(updateSumStarAndCommentCountQuery, data2, place_id);

                if (!result || !result2) {
                    res.status(500).send({
                        message: "Internel Server Error",
                        data: null
                    })
                } else {
                    res.status(200).send({
                        message: "Successful Get Comment Data",
                        data: null
                    });
                }
            } else {
                res.status(404).send({
                    message: "Not Found Comment Data",
                    data: null
                });
            }
        }
    }
    else {
        res.status(403).send({
            message: 'Access Denied'
        });
    }

});

module.exports = router;