# frozen_string_literal: true

require_relative "lib/json_jws/version"
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name = "json_jws"
  spec.version = JsonJws::VERSION
  spec.authors = ["Thien Tran"]
  spec.email = ["webmaster3t@gmail.com"]

  spec.summary = "JSON JWS with multiple signatures"
  spec.description = "JSON JWS with multiple signatures"
  spec.homepage = "https://github.com/thien0291/json_jws"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/thien0291/json_jws"
  spec.metadata["changelog_uri"] = "https://github.com/thien0291/json_jws/releases"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_development_dependency "byebug", "~> 11.1.3"
  spec.add_dependency "jose", "~> 1.2"
  spec.add_dependency "json", "~> 2.7.2"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
