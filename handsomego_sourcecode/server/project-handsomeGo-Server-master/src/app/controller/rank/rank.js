const express = require('express');
const router = express.Router();
const jwt = require('../../module/jwt.js');
const pool = require('../../module/pool.js');

router.get('/', async (req, res) => {

    const getRankQuery = 'SELECT place_id, place_name, place_star, place_category FROM place ORDER BY place_star DESC, place_name ASC';

    let getRankList = await pool.execute1(getRankQuery);

    if (!getRankList) {
        res.status(500).send({
            message: "Internel Server Error",
            data : null
        })
    } 
    else {
        res.status(200).send({
            message: "Successful Get Place Rank Data",
            data: getRankList
        });
    }

});

module.exports = router;