$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "effective_form_inputs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "effective_form_inputs"
  s.version     = EffectiveFormInputs::VERSION
  s.email       = ["info@codeandeffect.com"]
  s.authors     = ["Code and Effect"]
  s.homepage    = "https://github.com/code-and-effect/effective_form_inputs"
  s.summary     = "Collection of Form Inputs"
  s.description = "Collection of Form Inputs"
  s.licenses    = ['MIT']

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", [">= 3.2.0"]
  s.add_dependency "simple_form", [">= 3.1.0"]
end
