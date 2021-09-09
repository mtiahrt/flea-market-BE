const axios = require('axios');
const crypto = require('crypto');
const oauth1a = require('oauth-1.0a');

function Twitter(codes) {
    this.requestToken = codes?.requestToken ? codes.requestToken : null;
    this.tokenVerifier = codes?.tokenVerifier ? codes.tokenVerifier : null;
}

Twitter.prototype.getRequestToken = function() {
    const request = {
        url: `https://api.twitter.com/oauth/request_token?oauth_callback=${process.env.TWITTER_REDIRECT_URL}`,
        method: 'POST',
    };
    const authHeader = this.createAuth1Header(request);
    return axios.post(
        request.url,
        request.body,
        { headers: authHeader });
}

Twitter.prototype.buildJsonFromResponse = ({data}) => {
      let result = '{"' + data + '"}';
      return JSON.parse(result.replaceAll('=','":"').replaceAll('&','","'));
}

Twitter.prototype.getProfileAndToken = function() {
    //get access token
    return axios.post(`https://api.twitter.com/oauth/access_token?oauth_token=${this.requestToken}&oauth_verifier=${this.tokenVerifier}`)
        .then(response => {
            console.log(response.data);
            const accessCodes = this.buildJsonFromResponse(response);
            const request = {
                url: `https://api.twitter.com/1.1/account/verify_credentials.json?include_email=true`,
                method: 'GET',
            }
            const authHeader = this.createAuth1Header(request, accessCodes);
            //get the user data using the access token
            return axios.get(request.url, {headers: authHeader})
                .then(response => {
                    console.log(response.data);
                    return this.buildResponseObject(response.data, accessCodes.accessToken);
                }).catch(error => {
                    console.log(error.response.data);
                    return error.response.data;
                })
        }).catch(error => {
            console.log(error.response.data);
            return error.response.data;
        })
}
Twitter.prototype.createAuth1Header = function(request, accessCodes) {
    const oauth = oauth1a({
        consumer: { key: process.env.TWITTER_API_KEY, secret: process.env.TWITTER_API_SECRET },
        signature_method: 'HMAC-SHA1',
        hash_function(base_string, key) {
            return crypto
                .createHmac('sha1', key)
                .update(base_string)
                .digest('base64')
        },
    });
    const authorization = oauth.authorize(request, {
        key: accessCodes ? accessCodes.oauth_token : '',
        secret: accessCodes ? accessCodes.oauth_token_secret : '',
    });

    return oauth.toHeader(authorization);
}

Twitter.prototype.buildResponseObject = function(data, accessToken){
    return {
      userID: data.id,
      name: data.name,
      email: data.email,
      picture: data.profile_image_url,
      accessToken: accessToken,
      isLoggedIn: true
    }
  }

module.exports.Twitter = Twitter;