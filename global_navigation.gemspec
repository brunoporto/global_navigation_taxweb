$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "global_navigation/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "global_navigation"
  spec.version     = GlobalNavigation::VERSION
  spec.authors     = ["Bruno Porto"]
  spec.email       = ["brunotporto@gmail.com"]
  spec.homepage    = "http://www.taxweb.com.br/"
  spec.summary     = "Global Navigation"
  spec.description = "Global Navigation"
  spec.license     = "MIT"
  
  spec.files = Dir["{app,config,db,lib}/**/*", "Rakefile", "README.md"]
  spec.test_files = Dir["test/**/*"]

  spec.add_dependency 'haml'
  spec.add_dependency 'simple-navigation'
  spec.add_dependency 'sass-rails'
end
