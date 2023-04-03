const jwt = require("jsonwebtoken");

const tokenValidator = (app)=> {
    if (!process.env.DEVELOPMENT === 'false') {
        app.use((req, res, next) => {
            if (req.originalUrl === "/user/generateAccessToken") {
                next();
                return
            }
            const tokenValid = isAccessTokenValid(req, res);
            if (tokenValid !== true) {
                return res.status(401).send(tokenValid);
            }
            next()
        })
    }
}
const isAccessTokenValid = (req, res) => {
    let tokenHeaderKey = process.env.TOKEN_HEADER_KEY;
    let jwtSecretKey = process.env.JWT_SECRET_KEY;
    try {
        const token = req.header(tokenHeaderKey);
        const verified = jwt.verify(token, jwtSecretKey);
        if(verified){
            return true
        }else{
            // Access Denied
            return error
        }
    } catch (error) {
        // Access Denied
        return error
    }
}

module.exports = tokenValidator;