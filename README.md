This is a back node server for a graphQL service. Powered by [Postgraphile](https://www.graphile.org/)

All the heavy lifting has been done by postgraphile. https://www.graphile.org/

Environment variables `.env` are needed to be set to build the database url.  This URL will point postgraphile to your database to build your graphql server.  
An example file of all the environment variables are included in this repo.

First download and install postgres
https://postgresapp.com/downloads.html

note: you will also need something to interact with postgres.  I recommend [DBeaver](https://dbeaver.io/download/)

Second, build your postgres db with the scripts provide in this repo inside the `db` folder.

### Node version in use 16.15.1
install node version 16.15.1

## Add SSL certs
SSL certs are need because for the auth with Facebook, Google, Twitter.
I follow the information found here:

https://flaviocopes.com/express-https-self-signed-certificate/
But I will explain what is needed for ssl certs to work correctly next

First install openssl
```
brew install openssl
```
next run open ssl to generate the certs so OAUTH connections work locally

```
openssl req -nodes -new -x509 -keyout server.key -out server.cert
```
### In the prompts enter the following values:
Country Name (2 letter code)<br> 
US<br> 
State or Province Name (full name)<br> 
Colorado<br> 
Locality Name (eg, city)<br> 
Fort Collins

Organization Name (eg, company)<br> 
Tiahrt

Organizational Unit Name (eg, section)

Common Name (eg, fully qualified host name)

localhost

Email Address

mark.tiahrt@outlook.com

2 files will be generated `server.cert` and `server.key`.  Add those files to the root of this project if they are not already.
 note:  these same 2 certs also have to be copied over to the FE project too.  

Note: for a Mac you will have to tell your machine to trust the cert.  Here is how...

### Mac cert install
Open your keychain.  `cmd + space` type keychain access. In keychain access click
1. "login" on the left.
2. click File/import items in the menu at the top.
3. Select the server.cert file from its location.  Should be in the root of this project

Once it is added you need to tell the browser in this case Chrome to trust it.  
In keychain access
1. select the `certificates` tab at the top left
2. double-click on the local host cert
3. expand the `Trust` option
4. Select "When using this certificate: Always Trust"
    - This should set all the dropdowns items to "Always Trust"
5. save and close
6. close and restart chrome.

### .env set up
This project is running on 2 environments.  This requires 2 different .env files to be added to the project root ```.env.development``` and ```.env.production```.  Create those files and copy the contents of ```.env.example``` to both to jump start this setup.

### Install app
once node is installed you will need to install the application dependencies in order to run the app.
`npm install`.  Once the installation is complete and the sensitive data is added to the env files you can run the app.
`npm start-dev` to run on development `npm start-prod` to run on production aka the linux machine.  api URL will be https://localhost:8080/graphql.
This is the endpoint that frontend application is using. 

api testing and view the docs use: https://localhost:8080/graphiql

### Setting up Image bucket on AWS
The aws keys ```AWS_IMAGES_ACCESS_KEY_ID``` and ```AWS_IMAGES_SECRET_ACCESS_KEY``` are generated on aws.  These keys are created
by making a IAM user and an AWS S3 bucket.  I followed this video to set this up.  [Upload Images Directly to S3 from Front End](https://www.youtube.com/watch?v=yGYeYJpRWPM&list=LL&index=1&t=2s&ab_channel=SamMeech-Ward)

### Deployment
The production server is running on Heroku(basic plan).  It is deployed by committing the code changes to the 
Heroku git Repo.  URLs
`https://git.heroku.com/flea-market-be.git (fetch)`
`https://git.heroku.com/flea-market-be.git (push)`
