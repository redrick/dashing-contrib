require 'yaml'
require 'multi_json'

module DashingContrib
  module History
    extend self

    def history
      Sinatra::Application.settings.history
    end
    
    def raw_event(event_name)
      history[event_name].gsub(/^data:/, '')
    rescue
      nil
    end

    def json_event(event_name, default = nil)
      MultiJson.load(raw_event(event_name), { symbolize_keys: true })
    rescue
      default
    end

    def append_to(target_array=[], source_obj = {}, max_size=1000)
      target_array.shift while target_array.size >= max_size
      target_array << source_obj
    end
  end
end