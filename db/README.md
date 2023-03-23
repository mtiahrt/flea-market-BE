# flea-market-db
This is a docker image for the database for flea-market app.  

## pg_hba.config example 
https://github.com/derekjwilliams/covid-19-graphql/blob/master/pg_hba.example.conf

https://github.com/derekjwilliams/covid-19-graphql/blob/master/postgresql.example.conf

The changes I made were the following:<br>
pg_hba.conf line 12:<br>
```host all             all 192.168.1.12/16 trust # Allowing docker container connections to host db```<br>
postgresql.conf line 58:<br>
```listen_addresses='*' #only for dev, narrow this for production```
