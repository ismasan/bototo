require "bototo/version"
require 'ostruct'
require 'firering'
require 'multi_json'

module Bototo
  
  def self.setup(options = nil, &block)
    options.each do |k,v|
      config.send "#{k}=", v
    end if options.kind_of?(Hash)
    yield config if block_given?
    self
  end
  
  def self.config
    @config ||= Config.new
  end
  
  def self.default_bot
    @default_bot ||= Bot.new(config)
  end
  
  def self.register(handler_klass = nil, &block)
    Handlers.register handler_klass, &block
  end
  
  def self.run!
    Bototo.reload_handlers(false)
    EM.run do
      default_bot.run!
      trap("INT") { EM.stop }
    end
  end
  
  def self.reload_handlers(clear = true)
    # Undef handler constants to avoid redefinition warnings
    Handlers.handlers.each do |klass|
      klass.constants.each do |const|
        klass.send :remove_const, const.to_s
      end
    end
    # Clear handlers
    Handlers.handlers.clear if clear
    # Load all classes
    config.handler_paths.each do |path|
      if File.file?(path)
        Kernel.load path
      else
        Dir["#{path}/*.rb"].each do |file_path|
          Kernel.load file_path
        end        
      end
    end
  end
  
  class Config < OpenStruct
    DEFAULT_HANDLERS_PATH = File.join(File.dirname(__FILE__), 'bototo', 'handlers')
    
    def handler_paths
      @handler_paths ||= [DEFAULT_HANDLERS_PATH]
    end
  end
  
end

require 'bototo/bot'
require 'bototo/handlers'
