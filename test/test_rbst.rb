require 'test_helper'
require 'mocha'

class TestRbST < Test::Unit::TestCase
  def setup
    [:rst, :html, :latex].each do |f|
      instance_variable_set(
        :"@#{f}_file",
        File.join(File.dirname(__FILE__), 'files', "test.#{f}")
      )
    end
    @rst2parts_path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'rst2parts'))
  end
  
  should "call bare rest2parts when passed no options" do
    converter = RbST.new(@rst_file)
    converter.expects(:execute).with("python #{@rst2parts_path}/rst2html.py").returns(true)
    assert converter.convert
  end
  
  should "convert with custom executable" do
    executables = {:html => "/some/path/2html.py"}
    default_executables = RbST.executables
    RbST.executables = executables
    converter = RbST.new(@file)
    converter.expects(:execute).with("python #{executables[:html]}").returns(true)
    assert converter.to_html
    RbST.executables = default_executables
  end
  
  should "raise error when passed bad executable key" do
    executables = {:markdown => "/some/path/2markdown.py"}
    begin
      RbST.executables = executables
      flunk
    rescue ArgumentError
      assert true
    end
  end
  
  should "convert ReST to html" do
    html = RbST.new(@rst_file).to_html
    assert_equal html, File.read(@html_file)
  end
  
  should "convert ReST to LaTeX" do
    latex = RbST.new(@rst_file).to_latex
    assert_equal latex, File.read(@latex_file)
  end
  
  [:html, :latex].each do |f|
    should "accept options on #to_#{f}" do
      converter = RbST.new(@rst_file)
      converter.expects(:execute).with("python #{@rst2parts_path}/rst2#{f}.py --raw-enabled").returns(true)
      assert converter.send("to_#{f}", :raw_enabled)
    end
  end
  
  should "recognize strip_comments option" do
    html_with_comment = RbST.convert(".. comment")
    assert_equal html_with_comment, %Q{<div class="document">\n<!-- comment -->\n</div>}
    html_without_comment = RbST.convert(".. comment", 'strip-comments')
    assert_equal html_without_comment, %Q{<div class="document">\n</div>}
  end
  
  should "recognize cloak_email_addresses option" do
    html_with_uncloaked_email = RbST.convert("steve@mac.com")
    assert_equal %Q{<div class="document">\n<p><a class="reference external" href="mailto:steve&#64;mac.com">steve&#64;mac.com</a></p>\n</div>}, html_with_uncloaked_email
    html_with_cloaked_email = RbST.convert("steve@mac.com", 'cloak-email-addresses')
    assert_equal %Q{<div class="document">\n<p><a class="reference external" href="mailto:steve&#37;&#52;&#48;mac&#46;com">steve<span>&#64;</span>mac<span>&#46;</span>com</a></p>\n</div>}, html_with_cloaked_email
  end
  
  should "recognize part option" do
    html_body = RbST.convert("hello world", :part => :html_body)
    assert_equal %Q{<div class="document">\n<p>hello world</p>\n</div>}, html_body
    fragment = RbST.convert("hello world", :part => :fragment)
    assert_equal %Q{<p>hello world</p>}, fragment
  end
  
end
