# frozen_string_literal: true

require_relative 'lib/philiprehberger/color/version'

Gem::Specification.new do |spec|
  spec.name = 'philiprehberger-color'
  spec.version = Philiprehberger::Color::VERSION
  spec.authors = ['Philip Rehberger']
  spec.email = ['me@philiprehberger.com']

  spec.summary = 'Terminal ANSI color and styling with auto-detection'
  spec.description = 'A lightweight Ruby library for terminal ANSI color and styling ' \
                     'with chainable API, RGB/hex support, and automatic terminal detection.'
  spec.homepage = 'https://philiprehberger.com/open-source-packages/ruby/philiprehberger-color'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.1.0'

  spec.metadata = {
    'homepage_uri' => spec.homepage,
    'source_code_uri' => 'https://github.com/philiprehberger/rb-color',
    'changelog_uri' => 'https://github.com/philiprehberger/rb-color/blob/main/CHANGELOG.md',
    'bug_tracker_uri' => 'https://github.com/philiprehberger/rb-color/issues',
    'rubygems_mfa_required' => 'true'
  }

  spec.files = Dir['lib/**/*.rb', 'LICENSE', 'README.md', 'CHANGELOG.md']
  spec.require_paths = ['lib']
end
