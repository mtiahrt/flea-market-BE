const cors = require('cors');
const allowedOrigin = process.env.DEVELOPMENT ==='true' ? 'https://localhost:3000' : 'https://shopwildheather.com';

const myCors = cors({
    origin: '*'
    // origin: allowedOrigin
})

module.exports = myCors;