const axios = require('axios');
function Google({code})
{
  this.accessToken = code;
  this.userProfileURL = `https://www.googleapis.com/oauth2/v1/userinfo`;
}

Google.prototype.getProfileAndToken = function() {

  return axios.get(this.userProfileURL, {
      headers: {
          Authorization: `Bearer ${this.accessToken}`
      }
        }).then(({data}) => {
            return this.buildResponseObject(data);
    }).catch(error => {
      console.log('Error occured getting user data from Google');
      return error.response?.data?.error
    })
}
  
Google.prototype.buildResponseObject = function(data){
  return {
    userID: data.id,
    name: data.name,
    email: data.email,
    picture: data.picture,
    accessToken: this.accessToken,
    isLoggedIn: true
  }
}

module.exports.Google = Google