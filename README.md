# Create Campfire bots

```ruby
require 'bototo'

Bototo.setup do |config|
  config.bot_name       = 'mybot'
  config.subdomain      = 'mycompany'
  config.token          = 'campfire-api-token'
  config.room_name      = 'Main room'
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
```

On campfire, on the "Main room" room:

    mybot help
    
    mybot image me a cute cat
    
## Daemonizing

You can daemonize with God or Monit, or using the Daemons gem:

```ruby
require 'daemons'
require 'bototo'

# ... config

Bototo.register do

   # your commands here
   
end

# Run daemonized

Daemons.run_proc('my_bot') do
   Bototo.run!
end
```

Now you can control with

    $ ruby a_bot.rb start|stop|run|restart
