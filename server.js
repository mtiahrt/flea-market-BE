const pg = require("pg");
const express = require("express");
const { postgraphile, makePluginHook } = require("postgraphile");
const { default: PgPubsub } = require("@graphile/pg-pubsub");
const PgSimplifyInflectorPlugin = require("@graphile-contrib/pg-simplify-inflector");

const app = express();
require("dotenv").config();
const pluginHook = makePluginHook([PgPubsub]);

const pgPool = new pg.Pool({
  connectionString: process.env.RDS_URL,
});

try {
  app.use(
    postgraphile(pgPool, ["public"], {
      appendPlugins: [PgSimplifyInflectorPlugin],
      pluginHook,
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

//from old proc file
//web: postgraphile -c $RDS_URL --watch --simple-collections only --subscriptions
// --enhance-graphiql --cors --host 0.0.0.0 --port $PORT --show-error-stack=json
//--append-plugins @graphile-contrib/pg-simplify-inflector
