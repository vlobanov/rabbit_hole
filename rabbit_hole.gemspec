$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rabbit_hole/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rabbit_hole"
  s.version     = RabbitHole::VERSION
  s.authors     = ["Vadim Lobanov"]
  s.email       = ["lvadim1993@gmail.com"]
  s.homepage    = "https://github.com/vlobanov/rabbit_hole"
  s.summary     = "A small Rails 3 engine gem that allows to protect some controllers with password."
  s.description = "TODO: Description of RabbitHole."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.6"
end
