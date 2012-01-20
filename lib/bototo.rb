require "bototo/version"
require 'ostruct'
require 'firering'
require 'multi_json'

module Bototo
  
  def self.setup(&block)
    yield config if block_given?
    config
  end
  
  def self.config
    @config ||= Config.new
  end
  
  def self.default_bot
    @default_bot ||= Bot.new(config)
  end
  
  def self.register(&block)
    Handlers.register &block
  end
  
  def self.run!
    EM.run do
      default_bot.run!
      trap("INT") { EM.stop }
    end
  end
  
  class Config < OpenStruct; end
  
end

require 'bototo/bot'
require 'bototo/handlers'

Dir[File.dirname(__FILE__) + '/bototo/handlers/*.rb'].each do |path|
  require File.join('bototo', 'handlers', File.basename(path, '.rb'))
end
