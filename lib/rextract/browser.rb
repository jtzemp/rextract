require 'rextract'
require 'mechanize'
require 'time'

module Rextract
  
  module ArchiveResponse
    DEFAULT_ARCHIVE_DIR = File.expand_path(File.dirname("~/tmp"))
    def archive_dir
      @archive_dir ||= DEFAULT_ARCHIVE_DIR
    end
    
    def archive_dir=(dir_path)
      dir = File.expand_path(dir_path)
      FileUtils.mkdir_p(dir) unless File.exists?(dir)
      @archive_dir = dir
    end
    
    def get(*args)
      url = args.is_a?(Hash) ? args[:url] : args.first
      page = super(*args)
      File.open("#{archive_dir}/#{url}.html", "w+") do |f|
        f.write(page.to_s)
      end
      page
    end
  end
  
  module LogRequests
    def get(*args)
      url = args.is_a?(Hash) ? args[:url] : args.first
      $stderr.puts "[#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}] Requesting URL #{url}" # TODO Switch the STDERR.puts call with something that uses a _real_ logger
      super(*args)
    end
  end
  
  class Browser < Mechanize
    include ArchiveResponse
    include LogRequests
  end
end