$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ember_token_auth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ember_token_auth"
  s.version     = EmberTokenAuth::VERSION
  s.authors     = ["Kyle Davis"]
  s.email       = ["validkeys@gmail.com"]
  s.homepage    = "http://buildlab.co"
  s.summary     = "Contains the logic to login users"
  s.description = "Contains the logic to login users"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.8"
  s.add_dependency "bcrypt", "~> 3.1.7"
  s.add_dependency "jwt", "~> 1.4.1"
  s.add_development_dependency "sqlite3"
end
