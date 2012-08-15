$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "publinator/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "publinator"
  s.version     = Publinator::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Publinator."
  s.description = "TODO: Description of Publinator."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.1"
  s.add_dependency "transitions"
  s.add_dependency "paper_trail"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "cucumber-rails"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl"
end
