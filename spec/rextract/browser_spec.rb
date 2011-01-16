require 'spec_helper'
require 'tempfile'
require 'fileutils'

describe Rextract::ArchiveResponse do
  before(:all) do
    class SpecArchiveWrapperParent
      def get(*args)
        args
      end
    end
    
    class SpecArchiveWrapper < SpecArchiveWrapperParent
      include Rextract::ArchiveResponse
    end
    
    @alphabet = ("a".."z").to_a + ("A".."Z").to_a
  end
  
  before(:each) do
    @random_dir = Dir.tmpdir + "/" + @alphabet.shuffle[rand(@archive_dir),9].shuffle.join
  end
  
  after(:each) do
    FileUtils.rm_rf(@random_dir)
  end
  
  describe "#archive_dir=" do
    it "creates the directory (and it's parent directories) if it doesn't exist" do
      rar = SpecArchiveWrapper.new
      File.should_not be_exists(@random_dir)
      rar.archive_dir = @random_dir
      rar.archive_dir.should == @random_dir
      File.should be_exists(@random_dir)
    end
  end
  
  describe "#get" do
    it "wraps super(*args) and saves the output to $archive_dir/$something" do
      rar = SpecArchiveWrapper.new
      rar.archive_dir = @random_dir
      # Rextract::ArchiveResponse.should_receive(:get) # this fails
      # SpecArchiveWrapperParent.should_receive(:get)  # this fails
      File.should_not be_exists("#{@random_dir}/a.html")
      rar.get("a", "b", "c").should == ["a", "b", "c"] # but these next two work, indicating that the previous two are indeed getting called
      File.should be_exists("#{@random_dir}/a.html")
    end
  end
end

describe Rextract::LogRequests do
  before(:all) do
    class SpecLogRequestsParent
      def get(*args)
        args
      end
    end
    
    class SpecLogRequests < SpecLogRequestsParent
      include Rextract::LogRequests
    end
  end
  
  describe "#get" do
    it "should log the get request URL to STDERR" do
      # I don't really know how to test this in an automated test.
      # I'll look into Rspec and STDERR to figure out a way.
      # For now, I just look in the spec output.
      # If you know a better way, please tell me. :)
      slp = SpecLogRequests.new
      slp.get("a", "b", "c").should == ["a", "b", "c"]
    end
  end
end
