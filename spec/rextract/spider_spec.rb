require 'spec_helper'

describe Rextract::Spider do
  describe "#new" do
    describe "options hash tries to set all options on the Mechanize agent" do
      describe ":user_agent_alias" do
        it "accepts :ua_alias and passes it to the Mechanize agent" do
          spider = Rextract::Spider.new(:user_agent_alias => "Mac FireFox")
          spider.agent.user_agent.should == "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2) Gecko/20100115 Firefox/3.6"
        end
        
        it ":ua_alias defaults to 'Mac Safari'" do
          spider = Rextract::Spider.new
          spider.agent.user_agent.should == "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_2; de-at) AppleWebKit/531.21.8 (KHTML, like Gecko) Version/4.0.4 Safari/531.21.10"
        end
      end
      
      describe ":request_headers" do
        it "accepts :request_headers as a Hash" do
          spider = Rextract::Spider.new(:request_headers => {"Funky" => "Chicken"})
          spider.agent.request_headers.should == {"Funky" => "Chicken"}
        end
        
        it "defaults to none" do
          spider = Rextract::Spider.new
          spider.agent.request_headers.should == {}
        end
      end
    end
  end
  
  describe "#agent" do
    it "returns a Mechanize Agent" do
      spider = Rextract::Spider.new
      spider.agent.should be_a(Mechanize)
    end
  end
end
