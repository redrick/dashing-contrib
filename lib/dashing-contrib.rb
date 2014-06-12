require 'dashing-contrib/version'
require 'dashing-contrib/configuration'
require 'dashing-contrib/history'
require 'dashing-contrib/routes'
require 'dashing-contrib/bottles/time'

module DashingContrib
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration if block_given?
    self.configure_sprockets
  end

  private
  def self.configure_sprockets
    configuration.template_paths.each do |path|
      self.append_sprockets_path(path)
    end
  end

  def self.append_sprockets_path(path)
    puts "append to sprockets path: #{path}"
    puts Sinatra::Application.settings.sprockets

    Sinatra::Application.settings.sprockets.append_path(path)
  end
end


