require 'rextract'
require 'nokogiri'

class Rextract::Parser
  attr_reader :content, :doc
  
  def initialize(content)
    @content = content
    @doc = Nokogiri::HTML(content)
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
      key = method.scan(/parse_(\w*)/).flatten.first.to_sym
      result[key] = self.send(method.to_sym)
    end
    result
  end
end
