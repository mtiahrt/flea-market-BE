 This is a back node server for a graphQL service. Powered by Postgraphile

This service is running on Heroku. The postgress database is hosted on AWS. all the heavy lifting has been done by postgraphile. https://www.graphile.org/

Enviroment varables are need to be set to build the database url.  This URL will point postgraphile to your database to build your graphql server.  An example file of all the enviroment varables are included in this repo.

First, build you postgres db with the script provide in this repo.  Create a .env file at the root of the project.  copy the example env file to the .env file.  add your password.  

current url for this service. for development use https://flea-market-service.herokuapp.com/

api use https://flea-market-service.herokuapp.com/graphql

instructions for rebuilding this service is here https://www.graphile.org/postgraphile/deploying-heroku/

Heroku repo https://git.heroku.com/flea-market-service.git

To turn on the database on aws go to
https://us-east-2.console.aws.amazon.com/rds/home?region=us-east-2#database:id=flea-market;is-cluster=false


# Docker

to build the image run this command in the root of the project<br>
```docker build . -t postgraphile_api```

to run the image<br>
```docker run -p 8080:8080 -d postgraphile_api```
