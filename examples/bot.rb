$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'bototo'

Bototo.setup do |config|
  config.bot_name       = 'bamboo'
  config.subdomain      = 'mycompany'
  config.token          = 'my-campfire-api-token'
  config.room_name      = 'Bot-test'
  # config.max_retries = 10 # default to -1, which means perform connection retries on drop forever.
end

Bototo.register do
  
  on 'foo' do |value|
    say "#{user.name}: pong #{value}"
  end
  
  on 'bar' do |value|
    say "Bar? What?"
  end
  
  on(/^exp (\d+) (\d+)?/) do |int1, int2|
    say "Expression is #{int1} - #{int2}"
  end
  
end

Bototo.run!