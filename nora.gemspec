$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'nora/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'nora'
  s.version     = Nora::VERSION
  s.authors     = ['Shia']
  s.email       = ['rise.shia@gmail.com']
  s.homepage    = 'https://github.com/riseshia/nora'
  s.summary     = 'Summary of Nora.'
  s.description = 'Description of Nora.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.1.3'
  s.add_dependency 'omniauth'
  s.add_dependency 'omniauth-github'
  s.add_dependency 'octokit', '~> 4.0'
  s.add_dependency 'debride'

  s.add_development_dependency 'rspec-rails', '~> 3.6'
  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'denv'
  s.add_development_dependency 'byebug'
end
