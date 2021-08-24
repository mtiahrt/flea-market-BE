const Facebook = require('./Facebook').Facebook

function providerFactory(provider, code) {
  switch(provider) {
    case 'facebook':
      return new Facebook(code);
  }
}
const retriveUserProfile = (code, provider) => {
  const getUserProfile = new GetUserProfile();
  getUserProfile.setStrategy(providerFactory(provider, code));
  return getUserProfile.getProfileAndToken(code);
}

function GetUserProfile() {
  this.setStrategy = provider =>
  {
    this.provider = provider
  }
  this.getProfileAndToken = code => {
    return this.provider.getProfileAndToken()
  }
}

module.exports = {
  retriveUserProfile
}