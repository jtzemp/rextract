require 'rextract'

class Rextract::Spider
  attr_reader :agent
  def initialize(*opts)
    @agent = Rextract::Browser.new {|a|
      a.user_agent_alias = opts[:ua] || 'Mac Safari'
      a.follow_meta_refresh = true
    }
  end
  
end
