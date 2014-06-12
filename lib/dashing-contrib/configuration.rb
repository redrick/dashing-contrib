require 'pathname'

module DashingContrib
  class Configuration
    attr_accessor :template_paths

    def initialize
      @template_paths  = [File.expand_path("../", __dir__)]
    end
  end
end