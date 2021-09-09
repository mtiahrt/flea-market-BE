const Facebook = require('./Facebook').Facebook;
const Twitter = require('./Twitter').Twitter;
const Google = require('./Google').Google;

function providerFactory(provider, codes) {
  switch(provider) {
    case 'facebook':
      return new Facebook(codes);
    case 'twitter':
      return new Twitter(codes)
    case 'google':
      return new Google(codes);
  }
}
const retriveUserProfile = (codes, provider) => {
  const getUserProfile = new GetUserProfile();
  getUserProfile.setStrategy(providerFactory(provider, codes));
  return getUserProfile.getProfileAndToken();
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