const pg = require("pg");
const express = require("express");
const { postgraphile, makePluginHook } = require("postgraphile");
const { default: PgPubsub } = require("@graphile/pg-pubsub");
const PgSimplifyInflectorPlugin = require("@graphile-contrib/pg-simplify-inflector");

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

try {
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
  app.listen(process.env.PORT);
  console.log(
    `🚀 Server ready brower url https://flea-market-service.herokuapp.com/graphiql`
  );
} catch (error) {
  console.log(error);
}