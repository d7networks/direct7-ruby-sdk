Gem::Specification.new do |spec|
    spec.name          = "direct7"
    spec.version       = "0.0.2"
    spec.authors       = ["Direct7 Networks"]
    spec.email         = ["support@d7networks.com"]
    spec.summary       = "Ruby SDK for Direct7 Platform REST API"
    spec.description   = "This Ruby SDK provides a convenient and easy-to-use interface to the Direct7 REST API. The SDK allows you to perform
    all the operations that are available through the REST API."
    spec.homepage      = "https://github.com/d7networks/direct7-ruby-sdk.git"
    spec.license       = "MIT"
  
    spec.files         = Dir["{lib,doc}/**/*", "LICENSE.txt"]
    spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
    spec.require_paths = ["lib"]
  
    spec.add_dependency "json"
    spec.add_development_dependency "bundler"
  end