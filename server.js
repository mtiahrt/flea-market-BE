const pg = require("pg");
const fs = require('fs');
const express = require("express");
const https = require('https')
const { postgraphile, makePluginHook } = require("postgraphile");
const { default: PgPubsub } = require("@graphile/pg-pubsub");
const PgSimplifyInflectorPlugin = require("@graphile-contrib/pg-simplify-inflector");

try {
  const app = express();
  require("dotenv").config();
  const pluginHook = makePluginHook([PgPubsub]);
  const databaseURL = `postgres://${process.env.POSTGRES_USER}:` + 
                                `${process.env.POSTGRES_PASSWORD}@`+
                                `${process.env.POSTGRES_HOST}:` +
                                `${process.env.POSTGRES_PORT}/` + 
                                `${process.env.POSTGRES_DB}`;
  const pgPool = new pg.Pool({
    connectionString: databaseURL,
  });

  app.use(
    postgraphile(pgPool, ["public"], {
      appendPlugins: [PgSimplifyInflectorPlugin],
      pluginHook,
      enableCors: true,
      simpleCollections: "only",
      subscriptions: true,
      watchPg: true,
      simpleSubscriptions: true,
      graphiql: true,
      enhanceGraphiql: true,
    })
  );
//use https for development so all browsers work for testing
  if(process.env.DEVELOPMENT) {
    https.createServer({
      key: fs.readFileSync('server.key'),
      cert: fs.readFileSync('server.cert')
    }, app).listen(process.env.PORT, function () {
      console.log(`🚀 Server is Ready listening on port ${process.env.PORT}! Go to https://localhost:${process.env.PORT}/`)
    });
  }else{
    //for prod server https is already done by heroku
    app.listen(process.env.PORT);
    console.log(
      `🚀 Server ready brower url ${process.env.POSTGRES_HOST}:${process.env.PORT}/graphiql`
    );
  }

} catch (error) {
  console.log(error);
}