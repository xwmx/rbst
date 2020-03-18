# encoding: UTF-8

require 'helper'

describe RbST do
  def setup
    [:rst, :html, :latex].each do |f|
      instance_variable_set(
        :"@#{f}_file",
        File.join(File.dirname(__FILE__), 'files', "test.#{f}")
      )
    end
    @rst2parts_path = File.expand_path(
      File.join(File.dirname(__FILE__), '..', 'lib', 'rst2parts')
    )
  end

  it "should call bare rest2parts when passed no options" do
    converter = RbST.new(@rst_file)
    converter \
      .expects(:execute) \
      .with("python #{@rst2parts_path}/rst2html.py") \
      .returns(true)
    assert converter.convert
  end

  it "should convert with custom executable" do
    executables = {:html => "/some/path/2html.py"}
    default_executables = RbST.executables
    RbST.executables = executables
    converter = RbST.new(@rst_file)
    converter \
      .expects(:execute) \
      .with("python #{executables[:html]}") \
      .returns(true)
    assert converter.to_html
    RbST.executables = default_executables
  end

  it "should raise error when passed bad executable key" do
    executables = {:markdown => "/some/path/2markdown.py"}
    begin
      RbST.executables = executables
      flunk
    rescue ArgumentError
      assert true
    end
  end

  it "should convert ReST to html" do
    html = RbST.new(@rst_file).to_html
    assert_equal(
      File.read(@html_file),
      html
    )
  end

  it "should convert ReST to LaTeX" do
    latex = RbST.new(@rst_file).to_latex
    assert_equal(
      File.read(@latex_file),
      latex
    )
  end

  [:html, :latex].each do |f|
    it "should accept options on #to_#{f}" do
      converter = RbST.new(@rst_file)
      converter \
        .expects(:execute) \
        .with("python #{@rst2parts_path}/rst2#{f}.py --raw-enabled") \
        .returns(true)
      assert converter.send("to_#{f}", :raw_enabled)
    end
  end

  it "should recognize strip_comments option" do
    html_with_comment = RbST.convert(".. comment")
    assert_equal(
      html_with_comment,
      %Q{<div class=\"document\">\n<!-- comment -->\n</div>\n}
    )
    html_without_comment = RbST.convert(".. comment", 'strip-comments')
    assert_equal(
      html_without_comment,
      %Q{<div class=\"document\">\n</div>\n}
    )
  end

  it "should recognize cloak_email_addresses option" do
    html_with_uncloaked_email = RbST.convert("steve@mac.com")
    assert_equal(
      %Q{<div class=\"document\">\n<p>} +
      %Q{<a class=\"reference external\" href=\"mailto:steve&#64;mac.com\">} +
        %Q{steve&#64;mac.com</a>} +
      %Q{</p>\n</div>\n},
      html_with_uncloaked_email
    )
    html_with_cloaked_email = RbST.convert(
      "steve@mac.com", 'cloak-email-addresses'
    )
    assert_equal(
      %Q{<div class=\"document\">\n<p>} +
        %Q{<a class=\"reference external\" } +
        %Q{href=\"mailto:steve&#37;&#52;&#48;mac&#46;com\">} +
        %Q{steve<span>&#64;</span>mac<span>&#46;</span>com} +
        %Q{</a></p>\n</div>\n},
      html_with_cloaked_email
    )
  end

  it "should recognize part option" do
    html_body = RbST.convert("hello world", :part => :html_body)
    assert_equal(
      %Q{<div class=\"document\">\n<p>hello world</p>\n</div>\n},
      html_body
    )
    fragment = RbST.convert("hello world", :part => :fragment)
    assert_equal(
      %Q{<p>hello world</p>\n},
      fragment
    )
  end

  it "should convert to html with unicode" do
    test_string = "Hello ☃".force_encoding("utf-8")
    output = RbST.new(test_string).to_html(:part => :fragment)
    assert_equal(
      %Q{<p>#{test_string}</p>\n},
      output
    )
  end

  it "should convert to latex with unicode" do
    test_string = "Hello ☃".force_encoding("utf-8")
    output = RbST.new(test_string).to_latex(:part => :body)
    assert_equal(
      %Q{\n#{test_string}\n},
      output
    )
  end

  it "should execute with custom python path" do
    RbST.python_path = "/usr/bin/env python3"
    converter = RbST.new(@rst_file)
    converter \
      .expects(:execute) \
      .with("/usr/bin/env python3 #{@rst2parts_path}/rst2html.py") \
      .returns(true)
    assert converter.convert
    RbST.python_path = "python"
  end

  it "should convert to html with python3" do
    RbST.python_path = "/usr/bin/env python3"
    test_string = "Hello ☃".force_encoding("utf-8")
    output = RbST.new(test_string).to_html(:part => :fragment)
    assert_equal(
      %Q{<p>#{test_string}</p>\n},
      output
    )
    RbST.python_path = "python"
  end

  it "should convert to latex with python3" do
    RbST.python_path = "/usr/bin/env python3"
    test_string = "Hello ☃".force_encoding("utf-8")
    output = RbST.new(test_string).to_latex(:part => :body)
    assert_equal(
      %Q{\n#{test_string}\n},
      output
    )
    RbST.python_path = "python"
  end

  it "should convert to html with python2" do
    RbST.python_path = "/usr/bin/env python2"
    test_string = "Hello ☃".force_encoding("utf-8")
    output = RbST.new(test_string).to_html(:part => :fragment)
    assert_equal(
      %Q{<p>#{test_string}</p>\n},
      output
    )
    RbST.python_path = "python"
  end

  it "should convert to latex with python2" do
    RbST.python_path = "/usr/bin/env python2"
    test_string = "Hello ☃".force_encoding("utf-8")
    output = RbST.new(test_string).to_latex(:part => :body)
    assert_equal(
      %Q{\n#{test_string}\n},
      output
    )
    RbST.python_path = "python"
  end
end
