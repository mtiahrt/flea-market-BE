const {Pool} = require("pg");
require("dotenv").config();

const credentials = {
    user: process.env.POSTGRES_USER,
    host: process.env.POSTGRES_HOST,
    database: process.env.POSTGRES_DB,
    password: process.env.POSTGRES_PASSWORD,
    port: process.env.POSTGRES_PORT,
};

async function getUserRoles(userId){
    const pool = new Pool(credentials);
    const data = await pool.query(`SELECT application_user_id , n.id fleamarket_user_id, r.name
        FROM fleamarket.name n, fleamarket.role r
        WHERE  application_user_id = '${userId}'
        AND n.id = r.user_id`);
    await pool.end();
    return data.rows.map(x => x.name)
}
module.exports = {
    getUserRoles
}