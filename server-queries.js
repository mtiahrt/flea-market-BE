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

async function getProducts(items){
    const pool = new Pool(credentials);
    const cartIds = items.filter(x => x.inventoryItem === true).map(x => x.cartId).toString();
    const shippingId = items.filter(x=> x.inventoryItem === false).map(x => x.shippingId).toString();
    const data = await pool.query(
        `SELECT id, 1 quantity, id, price, name 
                        FROM fleamarket.shipping_cost sc 
                        WHERE id = ${shippingId}
                        UNION ALL
                        SELECT c.id, c.quantity, i.id, i.price, i.name 
                        FROM fleamarket.cart c, fleamarket.inventory i 
                        WHERE c.inventory_id = i.id 
                        AND c.id in (${cartIds})`)
    await pool.end();
    return data.rows.map(x => ({name: x.name, price: x.price, quantity: x.quantity}))
}
module.exports = {
    getUserRoles, getProducts
}