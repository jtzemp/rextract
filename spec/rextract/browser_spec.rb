require 'spec_helper'

class SpecArchiveWrapperParent
  def get(*args)
    OpenStruct.new(body: "body", header: [{ "header key" => "header value"}])
  end
end

class SpecArchiveWrapper < SpecArchiveWrapperParent
  include Rextract::ArchiveResponse
end


describe Rextract::ArchiveResponse do
  before(:each) do
    @alphabet = ("a".."z").to_a + ("A".."Z").to_a
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
      
      File.should_not be_exists("#{@random_dir}/a.html")
      page = rar.get('a')
      page.body.should == "body"
      page.header.should == [{"header key"=>"header value"}]
      File.should be_exists("#{@random_dir}/a.html")
    end
  end

  describe "#default_archive_dir" do
    it "takes an optional base param and returns a string representing the base path and the current timestamp"
  end

  describe "#write_to_file" do
    it "takes a path, and a string for data and writes the data to the path"
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
  
  before(:each) do
    $stderr = StringIO.new
  end
  
  after(:each) do
    $stderr = STDERR
  end
  
  describe "#get" do
    it "should log the get request URL to STDERR" do
      slp = SpecLogRequests.new
      slp.get("a", "b", "c").should == ["a", "b", "c"]
      $stderr.rewind
      $stderr.read.should match(/\[\d+-\d+-\d+\ \d+:\d+:\d+\] Requesting URL a/)
    end
  end
end
