# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = 'RbST'
  s.version = '0.5.1'
  s.licenses = ['MIT']
  s.summary = "A simple Ruby wrapper for processing reStructuredText via Python's Docutils"
  s.description = "A simple Ruby wrapper for processing reStructuredText via Python's Docutils"
  s.authors = ['William Melody']
  s.email = 'hi@williammelody.com'
  s.date = '2015-02-08'
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.md",
    "Rakefile",
    "RbST.gemspec",
    "lib/rbst.rb",
    "lib/rst2parts/__init__.py",
    "lib/rst2parts/rst2html.py",
    "lib/rst2parts/rst2latex.py",
    "lib/rst2parts/transform.py",
    "test/files/test.html",
    "test/files/test.latex",
    "test/files/test.rst",
    "test/helper.rb",
    "test/test_rbst.rb"
  ]
  s.homepage = "http://github.com/xwmx/rbst"
  s.require_paths = ['lib']
  s.add_development_dependency('mocha',     '~> 1',   '>= 0')
  s.add_development_dependency('rake',      '~> 12',  '>= 12.3.3')
  s.add_development_dependency('rdoc',      '~> 6',   '>= 0')
  s.add_development_dependency('shoulda',   '~> 3.5.0')
  s.add_development_dependency('test-unit', '~> 3',   '>= 0')
  s.required_ruby_version = '>= 2.3'
end
