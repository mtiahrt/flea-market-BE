# flea-market-db
This is a docker image for the database for flea-market app.  


To create the dmp files for docker to load

```pg_dump --verbose --host=localhost --port=5432 --username=postgres  --format=p --no-privileges --no-owner -n "app_private" postgres > 01_app_private.sql```

```pg_dump --verbose --host=localhost --port=5432 --username=postgres  --format=p --no-privileges --no-owner -n "fleamarket" postgres > 02_fleamarket.sql```

```pg_dump --verbose --host=localhost --port=5432 --username=postgres  --format=p --no-privileges --no-owner -n "postgraphile_watch" postgres > 03_postgraphile_watch.sql```


To build the image this on the run in the root of the projects. 
```docker build -t my-postgres-db ./   ```

once the the image is built run this to start the container

```docker run -d --name my-postgresdb-container -p 5432:5432 my-postgres-db```

# Postgres needs some configuration setting adjusted for containers
Postgres docker image works find when in a container and the local machine makes a request.
BUT if it comes from a different host or from a different docker container the request will fail.  
To fix this I had to adjust 2 configuration files on my local machine and then build an docker image.  The file names are postgresql.conf, and pg_hba.conf.  

To find the correct location of these files you can as postgresql using the psq command:
```
psql -U postgres -c 'SHOW config_file'
psql -U postgres -c 'SHOW hba_file'
```
mine were located in:<br>
```\users\marktiahrt\library\Application Support\Postgres\var-13```<br>
example files
https://github.com/derekjwilliams/covid-19-graphql/blob/master/pg_hba.example.conf

https://github.com/derekjwilliams/covid-19-graphql/blob/master/postgresql.example.conf

The changes I made were the following:<br>
pg_hba.conf line 12:<br>
```host all             all 192.168.1.12/16 trust # Allowing docker container connections to host db```<br>
postgresql.conf line 58:<br>
```listen_addresses='*' #only for dev, narrow this for production```
# TODO
move all tables and functions out of fleamarket and into the app_private schema