require 'rextract'

class Rextract::Spider
  attr_reader :agent
  def initialize(opts = {})
    @agent = Rextract::Browser.new do |a|
      if opts.is_a?(Hash)
        a.user_agent_alias    = opts[:ua_alias] || 'Mac Safari'
        a.request_headers     = opts[:request_headers] if opts.has_key?(:request_headers)
        a.follow_meta_refresh = true
      else
        a.user_agent_alias    = 'Mac Safari'
      end
    end
  end
  
end
