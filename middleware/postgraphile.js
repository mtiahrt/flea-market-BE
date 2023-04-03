const {postgraphile} = require("postgraphile");
const pg = require("pg");
const PgSimplifyInflectorPlugin = require("@graphile-contrib/pg-simplify-inflector");

const databaseURL = `postgres://${process.env.POSTGRES_USER}:` +
    `${process.env.POSTGRES_PASSWORD}@` +
    `${process.env.POSTGRES_HOST}:` +
    `${process.env.POSTGRES_PORT}/` +
    `${process.env.POSTGRES_DB}`;

const pgPool = new pg.Pool({
    connectionString: databaseURL,
});

const myPostgraphile = postgraphile(pgPool, process.env.POSTGRES_SCHEMA, {
    appendPlugins: [PgSimplifyInflectorPlugin],
    retryOnInitFail: true,
    enableCors: true,
    simpleCollections: "only",
    subscriptions: true,
    watchPg: true,
    simpleSubscriptions: true,
    graphiql: true,
    enhanceGraphiql: true,
});

module.exports = myPostgraphile;