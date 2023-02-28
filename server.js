require("dotenv").config();
const pg = require("pg");
const fs = require('fs');
const cors = require('cors');
const express = require("express");
const https = require('https');
const {postgraphile, makePluginHook} = require("postgraphile");
const {default: PgPubsub} = require("@graphile/pg-pubsub");
const PgSimplifyInflectorPlugin = require("@graphile-contrib/pg-simplify-inflector");
const {generateUploadImageURL, generateDeleteImageURL} = require("./s3Images");
const jwt = require('jsonwebtoken');
const {getUserRoles, getProducts} = require("./server-queries");
const {getAuth} = require("firebase-admin/auth");
const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);

try {
    const app = express();
    app.use(express.json());

    if (process.env.DEVELOPMENT) {//dev only
        app.use(cors({
            origin: 'https://localhost:3000'
        }));
    }

    if(!process.env.DEVELOPMENT){
        app.use((req, res, next) => {
            if(req.originalUrl === "/user/generateAccessToken"){
                next();
                return
            }
            const tokenValid = isAccessTokenValid(req, res);
            if(tokenValid !== true){
                return res.status(401).send(tokenValid);
            }
            next()
        })
    }


    const admin = require("firebase-admin");
    admin.initializeApp({
        credential: admin.credential.cert({
            projectId: process.env.FIREBASE_PROJECT_ID,
            clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
            privateKey: process.env.FIREBASE_PRIVATE_KEY?.replace(/\\n/g,'\n'),
        })
    })
    const pluginHook = makePluginHook([PgPubsub]);
    const databaseURL = `postgres://${process.env.POSTGRES_USER}:` +
        `${process.env.POSTGRES_PASSWORD}@` +
        `${process.env.POSTGRES_HOST}:` +
        `${process.env.POSTGRES_PORT}/` +
        `${process.env.POSTGRES_DB}`;
    const pgPool = new pg.Pool({
        connectionString: databaseURL,
    });

    app.use(
        postgraphile(pgPool, process.env.POSTGRES_SCHEMA, {
            appendPlugins: [PgSimplifyInflectorPlugin],
            pluginHook,
            retryOnInitFail: true,
            enableCors: true,
            simpleCollections: "only",
            subscriptions: true,
            watchPg: true,
            simpleSubscriptions: true,
            graphiql: true,
            enhanceGraphiql: true,
        })
    );

    app.get('/secureImageURL', async (req, res) => {
        const url = await generateUploadImageURL();
        res.send({url})
    });

    app.get('/secureImageDeleteURL', async (req, res) => {
        const publicID = req.query.publicId
        const url = await generateDeleteImageURL(publicID);
        res.send({url})
    });

    app.post('/user/generateAccessToken', async (req, res) => {
        const authToken = req.header('Auth-Token');
        // Validate auth token
        getAuth()
            .verifyIdToken(authToken)
            .then ( async decodedToken => {
                const roles = await getUserRoles(decodedToken.uid);
                // generate access Token
                let jwtSecretKey = process.env.JWT_SECRET_KEY;
                let data = {
                    issued: Date(),
                    userId: decodedToken.uid,
                    roles: roles
                }
                const token = jwt.sign(data, jwtSecretKey);
                res.send(token);
            })
    });

    app.post('/create-checkout-session', async (req, res) => {
        function convertDollarsToCents(value) {
            value = (value + '').replace(/[^\d.-]/g, '');
            if (value && value.includes('.')) {
                value = value.substring(0, value.indexOf('.') + 3);
            }

            return value ? Math.round(parseFloat(value) * 100) : 0;
        }

        try {
                //get item name and description
                const cartItems = await getProducts(req.body);
            const session = await stripe.checkout.sessions.create({
                    payment_method_types: ["card"],
                    mode: "payment",
                    line_items: cartItems.map(item => {
                        return {
                            price_data: {
                                currency: "usd",
                                product_data: {
                                    name: item.name,
                                },
                                unit_amount: convertDollarsToCents(item.price),
                            },
                            quantity: item.quantity,
                        }
                    }),
                    success_url: `${process.env.CHECK_OUT_RESULT_CLIENT_URL}/success.html`,
                    cancel_url: `${process.env.CHECK_OUT_RESULT_CLIENT_URL}/cancel.html`,
                })
                res.json({ url: session.url })
            }
            catch (e){
                res.status(500).json({ error: e.message })
        }
    })

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

//use https for development so all browsers work for testing
    if (process.env.DEVELOPMENT) {
        https.createServer({
            key: fs.readFileSync('server.key'),
            cert: fs.readFileSync('server.cert')
        }, app).listen(process.env.PORT, function () {
            console.log(`🚀 Development Server is Ready listening on port ${process.env.PORT}! Go to https://localhost:${process.env.PORT}/graphiql`)
        });
    } else {
        //for prod server https is already done by heroku
        app.listen(process.env.PORT);
        console.log(
            `🚀 Prod Server ready browser url localhost:${process.env.PORT}/graphiql`
        );
    }
} catch (error) {
    console.log(error);
}