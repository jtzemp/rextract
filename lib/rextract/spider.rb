require 'rextract'

class Rextract::Spider
  attr_reader :agent
  def initialize(opts = {})
    @agent = Rextract::Browser.new do |a|
      a.user_agent_alias    = opts[:user_agent_alias] || 'Mac Safari'
      a.follow_meta_refresh = true
      opts.each do |key, val|
        method = "#{key}="
        a.send(method, val) if a.respond_to?(method)
      end
    end
  end
  
end
