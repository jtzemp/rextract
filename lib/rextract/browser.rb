require 'rextract'
require 'mechanize'
require 'time'

module Rextract
  module ArchiveResponse
    DEFAULT_ARCHIVE_DIR = File.expand_path("~/tmp/" + Time.now.strftime("%Y-%m-%d_%H-%M-%S/")) 
    
    def initialize(*args)
      archive_dir=nil
      super(*args)
    end
    
    def archive_dir
      @archive_dir || (archive_dir = DEFAULT_ARCHIVE_DIR)
    end
    
    def ensure_dir(dir_path)
      FileUtils.mkdir_p(dir_path) unless File.exists?(dir_path)
    end
    
    def archive_dir=(dir_path)
      dir = File.expand_path(dir_path)
      ensure_dir(dir_path)
      @archive_dir = dir
    end
    
    def get(*args)
      url = args.is_a?(Hash) ? args[:url] : args.first
      body_path   = "#{archive_dir}/#{sanitize_url(url)}.html"
      header_path = "#{archive_dir}/#{sanitize_url(url)}.headers"
      ensure_dir(archive_dir)
      
      page = super(*args)
      File.open(body_path, "w+") do |f|
        f.write(page.body.to_s)
      end
      
      header_output = ''
      PP.pp(page.header, header_output)
      
      File.open(header_path, "w+") do |f|
        f.write(header_output)
      end
      
      page
    end
    
    def sanitize_url(url)
      url.gsub(/[^A-z0-9_\-\.]/, "_")
    end
  end
  
  module LogRequests
    def get(*args)
      url = args.is_a?(Hash) ? args[:url] : args.first
      $stderr.puts "[#{Time.now.strftime("%Y-%m-%d %H:%M:%S.%L")}] Requesting URL #{url}" # TODO Switch the STDERR.puts call with something that uses a _real_ logger
      super(*args)
    end
  end
  
  class Browser < Mechanize
    include ArchiveResponse
    include LogRequests
  end
end