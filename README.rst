RbST: A simple Ruby wrapper for processing reStructuredText via Python's Docutils.

RbST
====

Installation
------------

Python 2.3+ is required.

RbST is available on gemcutter.

::

    gem install gemcutter
    gem tumble
    gem install RbST

Usage
-----

::

    @html = RbST.new('/some/file.rst').to_html

This takes the reStructuredText formatted file and converts it to HTML. The first argument can be either a file or a string.

You can also use the ``#convert`` class method:

::

    puts RbST.convert('/some/file.rst')

When no options are passed, the default behavior converts reStructuredText to html. Options supported include ``:cloak_email_addresses`` and ``:strip_comments``, either of which can be simply included as additional arguements.

::

    puts RbST.convert(".. a comment", :strip_comments) # => '<div class="document">\n</div>'

Document parts can also be specified with the ``:parts`` option.

::

    puts RbST.convert("hello world", :part => :fragment) # => '<p>hello world</p>'


For more information on reStructuredText, see the
`ReST documentation <http://docutils.sourceforge.net/rst.html>`_.

Caveats
-------

- Docutils is very slow. On my 2.5 GHz Core 2 Duo it takes over half a second to convert the test file to HTML, taking about 0.2s to start up and 0.38s to process the input data.
-  This has only been tested on \*nix systems.
-  Python 3 has not been tested.

Note on Patches/Pull Requests
-----------------------------


-  Fork the project.
-  Make your feature addition or bug fix.
-  Add tests for it. This is important so I don't break it in a
   future version unintentionally.
-  Commit, do not mess with rakefile, version, or history. (if you
   want to have your own version, that is fine but bump version in a
   commit by itself I can ignore when I pull)
-  Send me a pull request. Bonus points for topic branches.

Copyright
---------

Copyright (c) 2009 William Melody. See LICENSE for details.