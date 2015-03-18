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