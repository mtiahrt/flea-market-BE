const pg = require("pg");
const express = require("express");
const { postgraphile, makePluginHook } = require("postgraphile");
const { default: PgPubsub } = require("@graphile/pg-pubsub");
const app = express();
const pluginHook = makePluginHook([PgPubsub]);

const pgPool = new pg.Pool({
  connectionString: $RDS_URL,
});
app.use(
  postgraphile(pgPool, ["public"], {
    pluginHook,
    subscriptions: true,
    simpleSubscriptions: true,
    graphiql: true,
    enhanceGraphiql: true,
  })
);
app.listen($PORT);
console.log(
  `🚀 Server ready brower url https://flea-market-service.herokuapp.com/graphiql`
);

//from old proc file
//web: postgraphile -c $RDS_URL --watch --simple-collections only --subscriptions
// --enhance-graphiql --cors --host 0.0.0.0 --port $PORT --show-error-stack=json
//--append-plugins @graphile-contrib/pg-simplify-inflector