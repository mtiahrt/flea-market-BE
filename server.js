require("dotenv").config({path: `${process.env.ENV_FILE}`});
const fs = require('fs');
const express = require("express");
const https = require('https');
const limiter = require('./middleware/rate-limiter');
const myCors = require('./middleware/cors');
const myPostgraphile = require('./middleware/postgraphile');
const routes = require('./routes');
const tokenValidator = require('./middleware/token-verify');
try {
    const app = express();
    app.use(express.json());
    app.use(myCors);
    app.use(limiter);
    tokenValidator(app);
    app.use(myPostgraphile);
    app.use(routes);
    const admin = require("firebase-admin");
    admin.initializeApp({
        credential: admin.credential.cert({
            projectId: process.env.FIREBASE_PROJECT_ID,
            clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
            privateKey: process.env.FIREBASE_PRIVATE_KEY?.replace(/\\n/g,'\n'),
        })
    })

//use https for development so all browsers work for testing
    if (process.env.DEVELOPMENT === 'true') {
        https.createServer({
            key: fs.readFileSync('server.key'),
            cert: fs.readFileSync('server.cert')
        }, app).listen(process.env.PORT, function () {
            console.log(`🚀 Development Server is Ready listening.  Go to https://localhost:${process.env.PORT}/graphiql`)
        });
    } else {
        //for prod server https is already done by heroku
        app.listen(process.env.PORT);
        console.log(
            `🚀 Production server ready browser url https://flea-market-be.herokuapp.com/graphiql`
        );
    }
} catch (error) {
    console.log(error);
}