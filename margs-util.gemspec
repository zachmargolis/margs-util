# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'margs/util/version'

Gem::Specification.new do |spec|
  spec.name          = "margs-util"
  spec.version       = Margs::Util::VERSION
  spec.authors       = ["Zach Margolis"]
  spec.email         = ["zbmargolis@gmail.com"]

  spec.summary       = %q{Marg's simple utility scripts}
  spec.description   = %q{Simple scripts for ImageMagick, URLs, JSON}
  spec.homepage      = "https://github.com/zachmargolis/margs-util"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'rack'
end
