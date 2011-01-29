require 'rextract'
require 'nokogiri'

class Rextract::Parser
  attr_reader :content, :doc, :opts
  
  def initialize(content, *opts)
    @opts = opts
    case content
    when content.respond_to?(:parser) && content.respond_to?(:html_body)
      @doc     = content.parser
      @content = content.html_body
    when content.respond_to?(:body)
      @doc     = content
      @content = content.body
    else
      @doc     = Nokogiri::HTML(content.to_s)
      @content = content.to_s
    end
  end

  def extract(regex)
    @content.scan(regex).flatten.first
  end

  def parsing_methods
    (self.methods - self.class.superclass.methods).collect{|m| m if m =~ /parse_/}.compact
  end
    
  def parse
    result = {}
    parsing_methods.each do |method|
      key = method.to_s.scan(/parse_(\w*)/).flatten.first.to_sym
      result[key] = self.send(method.to_sym)
    end
    result
  end
end
