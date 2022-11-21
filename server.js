const pg = require("pg");
const fs = require('fs');
const cors = require('cors');
const express = require("express");
const https = require('https')
const {postgraphile, makePluginHook} = require("postgraphile");
const {default: PgPubsub} = require("@graphile/pg-pubsub");
const PgSimplifyInflectorPlugin = require("@graphile-contrib/pg-simplify-inflector");
const {generateUploadImageURL, generateDeleteImageURL} = require("./s3Images");

try {
    const app = express();
    require("dotenv").config();

    if (process.env.DEVELOPMENT) {//dev only
        app.use(cors({
            origin: 'https://localhost:3000'
        }));
    }

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

    //TODO lock down this end point with Auth...
    app.get('/secureImageURL', async (req, res) => {
        const url = await generateUploadImageURL();
        res.send({url})
    })

    //TODO lock down this end point with Auth...
    app.get('/secureImageDeleteURL', async (req, res) => {
        const publicID = req.query.publicId
        const url = await generateDeleteImageURL(publicID);
        res.send({url})
    })

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
