#!/usr/bin/env ruby
require 'rubygems'
require 'thor/group'
require 'thor/actions'
require 'active_support/inflector'


class Thortest < Thor::Group
  include Thor::Actions

  # Define arguments and options
  argument :job_name
  #class_option :test_framework, :default => :test_unit

  def self.source_root
    r = File.dirname(__FILE__)
    STDERR.puts "source_root: #{r}"
    r
  end

  def self.dest_root
    STDERR.puts "dest_root: #{Dir.pwd}"
    Dir.pwd
  end

  def wookie
    source      = "job"
    destination = job_name
    STDERR.puts "copying #{source} to #{destination}"
    directory(source, destination)
  end

  # def create_lib_file
  #   template('templates/newgem.tt', "#{name}/lib/#{name}.rb")
  # end
  # 
  # def create_test_file
  #   test = options[:test_framework] == "rspec" ? :spec : :test
  #   create_file "#{name}/#{test}/#{name}_#{test}.rb"
  # end
  # 
  # def copy_licence
  #   if yes?("Use MIT license?")
  #     # Make a copy of the MITLICENSE file at the source root
  #     copy_file "MITLICENSE", "#{name}/MITLICENSE"
  #   else
  #     say "Shame on you...", :red
  #   end
  # end
end
puts "monkey at the end, but before start"

#tt = Thortest.new(:name=>"funkd")
Thortest.start