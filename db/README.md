# flea-market-db
This is a docker image for the database for flea-market app.  

## pg_hba.config example 
https://github.com/derekjwilliams/covid-19-graphql/blob/master/pg_hba.example.conf

https://github.com/derekjwilliams/covid-19-graphql/blob/master/postgresql.example.conf

The changes I made were the following:
pg_hba.conf line 12:
```
# TYPE  DATABASE        USER            	ADDRESS                 METHOD
host    all             postgres                localhost               scram-sha-256
host 	all 		fleamarketadmin 	 11.22.333.444/0 	  scram-sha-256
```
