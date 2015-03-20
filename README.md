# ember-token-auth
A rails gem for token authentication handling with ember-cli-simple-auth and ember-cli-simple-auth-jwt

Add the following to your gemfile

```
# local
gem "ember_token_auth", path: "../ember-token-auth"

#remove
gem "ember_token_auth", git: "git:github.com:validkeys/ember-token-auth.git"
```

Then run:

```
rake ember_token_auth:install
```

This will:
* create a secret_token in config/initializers/secret_token
* copy over a user model (unless you have one)

Then include the application controller concern:

```ruby
include EmberTokenAuth::ApplicationController
```

Then in your user model, include the user concern

```ruby
include EmberTokenAuth::UserModel
```

Then in your user controller, include the user controller concern
```ruby
include EmberTokenAuth::UsersController
```

## Ember Installation


1. Start by installing ember-simple auth

```
npm install --save-dev ember-cli-simple-auth
ember generate ember-cli-simple-auth
```

2. Then install ember-cli-simple-auth-token
```
npm install --save-dev ember-cli-simple-auth-token
ember generate simple-auth-token
```

3. Next ensure your application route has the ember-simple-auth mixin
```javascript
import Ember from 'ember';
import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin';

export default Ember.Route.extend(ApplicationRouteMixin, {

});
```

4. Update env config with the following (tweak as needed)
```javascript
  ENV['simple-auth'] = {
    authorizer: 'simple-auth-authorizer:token',
    store:      'simple-auth-session-store:local-storage'
  }

  ENV['simple-auth-token'] = {
    authorizer:               'simple-auth-authorizer:token',
    serverTokenEndpoint:      '/sessions/token',
    identificationField:      'email',
    passwordField:            'password',
    tokenPropertyName:        'token',
    authorizationPrefix:      'Bearer ',
    authorizationHeaderName:  'Authorization',
    headers: {},
    // JWT specific vv
    refreshAccessTokens:        true,
    serverTokenRefreshEndpoint: '/sessions/token_refresh/',
    tokenExpireName:            'exp',
    timeFactor:                 1  // example - set to "1000" to convert incoming seconds to milliseconds.
  }
```

5. Now create your login route and controller. Ensure the login controller mixes in the ember-simple-auth login controller mixin

```javascript
import Ember from 'ember';
import LoginControllerMixin from 'simple-auth/mixins/login-controller-mixin';

export default Ember.Controller.extend(LoginControllerMixin, {
  authenticator: 'simple-auth-authenticator:jwt'
});
```

Your login form should look something like this: (Note that "identification" is used for the email address here.)

```handlebars
<form {{action 'authenticate' on='submit'}}>
  <div class="form-item">
    <label for="identification">Login</label>
    {{input id='identification' placeholder='Enter Login' value=identification}}
  </div>
  <div class="form-item">
    <label for="password">Password</label>
    {{input id='password' placeholder='Enter Password' type='password' value=password}}
  </div>
  <div class="form-item">
    <button type="submit" class="btn cta">Login</button>
  </div>
</form>
```

Now you should be set.

6. Create your signup route and controller. The form's submit action should be "signup.". The signup route should have (at least), the following action. This action signs the user up and then logs them in

```javascript
  actions: {
    signup: function() {
      var _this     = this,
          userProps = this.controllerFor("signup").getProperties("firstName", "lastName", "email", "password"),
          user      = this.store.createRecord('user', userProps);

      // create the user
      user.save()
        .then(function(res){

          // authenticate the user
          return _this.get("session")
            .authenticate("simple-auth-authenticator:jwt", { identification: userProps.email, password: userProps.password })
        })
        .then(function(res){
          console.log("Authentication succeeded!", res);
        })
        .catch(function(err){
          console.warn("User creation error", err);
        })
    }
  }
```


### Todo

* Automatically include the above concerns in the proper controllers and models
* Currently relies on email and password fields. Should make these config options (ex. username)
