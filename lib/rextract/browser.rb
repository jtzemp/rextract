require 'rextract'
require 'mechanize'
require 'time'

module Rextract
  module ArchiveResponse
    
    def initialize(*args)
      @archive_dir=nil
      super(*args)
    end
    
    def default_archive_dir(base = "~/tmp/")
      File.expand_path(base + Time.now.strftime("%Y-%m-%d_%H-%M-%S/")) 
    end

    def archive_dir
      @archive_dir || (archive_dir = default_archive_dir)
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

      write_to_file(body_path, page.body.to_s)
      
      header_output = ''
      PP.pp(page.header, header_output)
      
      write_to_file(header_path, header_output)
      
      page
    end

    def write_to_file(path, data)
      File.open(path, "w+") do |f|
        f.write(data)
      end
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
