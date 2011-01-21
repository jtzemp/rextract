require 'spec_helper'

describe Rextract::Parser do
  before(:each) do
    @html =<<EOHTML
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>test html</title>
	<meta name="generator" content="TextMate http://macromates.com/">
	<meta name="author" content="Author Name">
	<!-- Date: 2011-01-19 -->
</head>
<body>
<div id="content"><div id="left_nav">navbar</div></div>
</body>
</html>
EOHTML
  end
  describe ".new" do
    it "takes a string of HTML and loads it into Nokogiri" do
      p = Rextract::Parser.new(@html)
      p.doc.should be_a(Nokogiri::HTML::Document)
      p.doc.css("#left_nav").inner_text.should == "navbar"
    end
  end
  
  describe "#extract" do
    it "takes a regular expression and returns the first match" do
      p = Rextract::Parser.new(@html)
      p.extract(%r{<meta name="author" content="(.+)"}).should == "Author Name"
    end
  end
  
  describe "#parsing_methods" do
    before(:all) do
      class SampleParser < Rextract::Parser
        def parse_generator ; end
        def parse_nothing ; end
        def parse_lang ; end
      end
    end
    it "returns an array of methods that start with 'parse_' " do
      p = SampleParser.new(@html)
      p.parsing_methods.sort.should == ["parse_lang", "parse_generator", "parse_nothing"].sort
    end
  end
end
