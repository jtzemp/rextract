module Rextract
  require 'rextract/browser'
  require 'rextract/spider'
  require 'rextract/parser'
  VERSION = File.open(File.expand_path(File.dirname(__FILE__)) + "/../VERSION").read
end