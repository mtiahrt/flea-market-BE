const Facebook = require('./Facebook').Facebook;
const Twitter = require('./Twitter').Twitter;

function providerFactory(provider, code) {
  switch(provider) {
    case 'facebook':
      return new Facebook(code);
    case 'twitter':
      return new Twitter(code)
  }
}
const retriveUserProfile = (code, provider) => {
  const getUserProfile = new GetUserProfile();
  getUserProfile.setStrategy(providerFactory(provider, code));
  return getUserProfile.getProfileAndToken(code);
}

const retriveTwitterRequestToken = () => {
  const twitter = new Twitter();
  return twitter.getRequestToken().then(response => twitter.buildJsonFromResponse(response));
}

function GetUserProfile() {
  this.setStrategy = provider =>
  {
    this.provider = provider
  }
  this.getProfileAndToken = () => {
    return this.provider.getProfileAndToken()
  }
}

module.exports = {
  retriveUserProfile, retriveTwitterRequestToken
}