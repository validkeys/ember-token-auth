$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ember_token_auth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ember_token_auth"
  s.version     = EmberTokenAuth::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of EmberTokenAuth."
  s.description = "TODO: Description of EmberTokenAuth."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.8"
  s.add_dependency "bcrypt", "~> 3.1.7"
  s.add_dependency "jwt", "~> 1.4.1"
  # s.add_development_dependency "sqlite3"
end
