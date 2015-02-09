# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "RbST"
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["William Melody"]
  s.date = "2015-02-08"
  s.description = "A simple Ruby wrapper for processing reStructuredText via Python's Docutils"
  s.email = "hi@williammelody.com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.markdown"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.markdown",
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
  s.homepage = "http://github.com/alphabetum/rbst"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "A simple Ruby wrapper for processing reStructuredText via Python's Docutils"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency('mocha', '~> 1.1', '> 1.1.0')
      s.add_development_dependency('rake', '~> 10.4', '>= 10.4.2')
      s.add_development_dependency('rdoc', '~> 4.2', '>= 4.2.0')
      s.add_development_dependency('shoulda', '~> 3.5', '>= 3.5.0')
      s.add_development_dependency('test-unit', '~> 3.0', '>= 3.0.9')
    else
      s.add_dependency(%q<mocha>, ["~> 1.1.0"])
      s.add_dependency(%q<rake>, ["~> 10.4.2"])
      s.add_dependency(%q<rdoc>, ["~> 4.2.0"])
      s.add_dependency(%q<shoulda>, ["~> 3.5.0"])
      s.add_dependency(%q<test-unit>, ["~> 3.0.9"])
    end
  else
    s.add_dependency(%q<mocha>, ["~> 1.1.0"])
    s.add_dependency(%q<rake>, ["~> 10.4.2"])
    s.add_dependency(%q<rdoc>, ["~> 4.2.0"])
    s.add_dependency(%q<shoulda>, ["~> 3.5.0"])
    s.add_dependency(%q<test-unit>, ["~> 3.0.9"])
  end
end
