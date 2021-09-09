const axios = require('axios');
function Facebook({code})
{
  this.accessToken = '';
  this.code = code;
  this.tokenURL = `https://graph.facebook.com/v11.0/oauth/access_token?client_id=${process.env.FACEBOOK_APP_ID}&redirect_uri=${process.env.REDIRECT_URL}&client_secret=${process.env.FACEBOOK_SECRET}&code=${code}`;
}

Facebook.prototype.getProfileAndToken = function() {
  return axios.get(this.tokenURL).then(({data}) => {
    this.accessToken = data.access_token;
    return axios.get('https://graph.facebook.com/me?fields=id,name,picture,email', {
      headers: {'Authorization': `Bearer ${data.access_token}`}})
      .then(({data}) => {
        data.accessToken = this.accessToken;
        return this.buildResponseObject(data);
      })
    }).catch(error => {
      console.log('Error occured');
      return error.response?.data?.error
    })
}
  
Facebook.prototype.buildResponseObject = function(data){
  return {
    userID: data.id,
    name: data.name,
    email: data.email,
    picture: data.picture.data.url,
    accessToken: data.accessToken,
    isLoggedIn: true
  }
}

module.exports.Facebook = Facebook