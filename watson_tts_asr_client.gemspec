# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'watson_tts_asr_client/version'

Gem::Specification.new do |spec|
  spec.name          = "watson_tts_asr_client"
  spec.version       = WatsonTtsAsrClient::VERSION
  spec.authors       = ["Eric Vennaro"]
  spec.email         = ["epv9@case.edu"]

  spec.summary       = %q{Watson TTS and ASR client for ruby.}
  spec.description   = %q{Ruby API client for connecting to the Watson Text To Speech (TTS) and Automated Speech Recognition (ASR).}
  spec.homepage      = "https://www.github.com/epv44/WatsonAPIClient."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency 'rake', '~> 11.3'
  spec.add_development_dependency 'minitest', '~> 5.8'
  spec.add_development_dependency 'webmock', '~> 2.3'
  spec.add_dependency 'railties', '~> 5.0'
  spec.add_dependency 'websocket-eventmachine-client', '~> 1.2'
  spec.add_dependency 'activesupport', '~> 5.0', '>= 5.0.0.1'
end
