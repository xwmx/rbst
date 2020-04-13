# RbST

[![Build Status](https://travis-ci.org/xwmx/rbst.svg?branch=master)](https://travis-ci.org/xwmx/rbst)
[![Gem Version](https://img.shields.io/gem/v/RbST?color=blue)](http://rubygems.org/gems/RbST)

A Ruby gem for processing
[reStructuredText](https://en.wikipedia.org/wiki/ReStructuredText) via Python's
[Docutils](https://pypi.org/project/docutils/).

## Installation

Python 2.3+ (or 3.3+) is required.

RbST is available on [RubyGems](https://rubygems.org/gems/RbST):

```bash
gem install RbST
```

To install with [Bundler](https://bundler.io/), add the following to your Gemfile:

```ruby
gem 'RbST'
```

Then run `bundle install`

## Usage

```ruby
require 'rbst'
@latex = RbST.new('*hello*').to_latex
```

This takes the reStructuredText formatted string and converts it to LaTeX.

The first argument can be either a string or an array of one or more file
paths. The files will be concatenated together with a blank line between
each and used as input.

```ruby
# One file path as a single-element array.
RbST.new(['/path/to/file.rst']).to_html

# Multiple file paths as an array.
RbST.new(['/path/to/file1.rst', '/path/to/file2.rst']).to_html
```

You can also use the `convert` class method to output HTML:

```ruby
puts RbST.convert('*hello*')
#=> "<div class=\"document\">\n<p><em>hello</em></p>\n</div>\n"
```

Arguments can be passed to `#to_html`, `#to_latex`, `new` or `convert`,
accepting symbols or strings for options without arguments and hashes of
strings or symbols for options with arguments.

```ruby
puts RbST.new('.. a comment').to_html('strip-comments')
# => '<div class="document">\n</div>'
```

Options passed as string use hyphens while symbols use underscores. For
instance, the above could also be written as:

```ruby
puts RbST.new('.. a comment').to_html(:strip_comments)
# => '<div class="document">\n</div>'
```

Document parts can also be specified with the `:parts` option.

```ruby
puts RbST.new('hello world').to_html(:part => :fragment)
# => '<p>hello world</p>'
```

By default, RbST uses the `html_body` part for HTML and the `whole` part
for LaTeX.

Available options can be viewed using the `RbST.html_options` and
`RbST.latex_options` class methods.

You might run into a situation where you want to specify a custom script for
processing one or both of the output formats. If so, just specify the full
path to the custom script for the format by passing a hash to the
`RbST.executables=` method:

```ruby
RbST.executables = {:html => '/some/other/path/2html.py'}

# uses custom executable for outputting html
RbST.new('*hello*').to_html

# uses default executable for latex since a custom one wasn't specified
RbST.new('*hello*').to_latex
```

Similarly, if you want to explicitly specify which python executable to
use, set the path with the `RbST.python_path=` method:

```ruby
RbST.python_path = '/usr/bin/env python3'
RbST.new('*hello*').to_latex
```

For more information on reStructuredText, see the
[ReST documentation](http://docutils.sourceforge.net/rst.html).

## Note on Patches/Pull Requests

- Fork the project.
- Make your feature addition or bug fix.
- Add tests for it. This is important so I don't break it in a future version
  unintentionally.
- Commit, do not mess with rakefile, version, or history. (if you want to have
  your own version, that is fine but bump version in a commit by itself I can
  ignore when I pull)
- Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2009 William Melody. See LICENSE for details.
