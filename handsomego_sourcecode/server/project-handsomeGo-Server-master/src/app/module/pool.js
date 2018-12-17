const pool = require('../../config/db_pool.js');

//DB 통신 모듈화
//매개변수
//1번째 : query문
//2번째 : data(json 형식 가능)

module.exports = {
    //인수 1개, 전체 조회
    execute1 : async (...args) => {
        const query = args[0];
        let result;
        try {
            var connection = await pool.getConnection();
            result = await connection.query(query) || null;
        }
        catch(err) {
            next(err);
        }
        finally {
            pool.releaseConnection(connection);
            return result;
        }
    },
    //인수 2개
    execute2 : async (...args) => {
        const query = args[0];
        const data = args[1];
        let result;
        try {
            var connection = await pool.getConnection();
            result = await connection.query(query, data) || null;
        }
        catch(err) {
            next(err);
        }
        finally {
            pool.releaseConnection(connection);
            return result;
        }
    },
    //인수 3개
    execute3 : async (...args) => {
        const query = args[0];
        const data = args[1];
        const data2 = args[2];
        let result;
        try {
            var connection = await pool.getConnection();
            result = await connection.query(query, [data, data2]) || null;
        }
        catch(err) {
            next(err);
        }
        finally {
            pool.releaseConnection(connection);
            return result;
        }
    },
    //인수 4개
    execute4 : async (...args) => {
        const query = args[0];
        const data = args[1];
        const data2 = args[2];
        const data3 = args[3];
        let result;
        try {
            var connection = await pool.getConnection();
            result = await connection.query(query, [data, data2, data3]) || null;
        }
        catch(err) {
            next(err);
        }
        finally {
            pool.releaseConnection(connection);
            return result;
        }
    }
};
