
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "popularity/version"

Gem::Specification.new do |spec|
  spec.name          = "popularity"
  spec.version       = Popularity::VERSION
  spec.authors       = ["Jeff Keen"]
  spec.email         = ["jeff@keen.me"]

  spec.summary       = %Q{Popularity searches social networks a url and returns the metrics.}
  spec.description   = %Q{Supports Facebook, Pinterest, Reddit (Links, Posts, and Comments), Github, Soundcloud, Medium, and Rubygems}
  spec.homepage      = "http://github.com/jkeen/popularity"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]


  spec.add_dependency "open_uri_redirections", "~> 0"
  spec.add_dependency "json", "~> 1.8"
  spec.add_dependency "unirest", "~> 1.1.2"
  spec.add_dependency "pry"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "webmock", "~> 2.3.1"
  spec.add_development_dependency "vcr", "~> 2.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "shoulda", ">= 0"
  spec.add_development_dependency "simplecov", "~> 0"
  spec.add_development_dependency "awesome_print", "~> 1.6"
end
