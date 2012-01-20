# Create Campfire bots

```ruby
require 'bototo'

Bototo.setup do |config|
  config.bot_name       = 'mybot'
  config.subdomain      = 'mycompany'
  config.token          = 'campfire-api-token'
  config.room_name      = 'Main room'
  # config.handler_paths << File.dirname(__FILE__) + '/my_handlers' # load custom handlers from here
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
    

Run examples/bot.rb

    $ ruby examples/bot.rb

## Custom handler classes

Bototo.register do ... end is fine for small command handlers. For anything more complicated you can create your own class extending from Bototo::Handlers::Base

```ruby
class PrivateStatusHandler < Bototo::Handlers::Base
  
  URL = 'https://my.api.com/status'
  
  on "what's the status" do 
    get_json(URL) do |json|
      paste formatted(json)
    end
  end
  
  on /my bank account balance for (.+)/ do |date|
    # talk to your bank's API, or something
    say "My balance is ..."
  end
  
  protected
  
  def protected(json)
    # ... format json into nice string
    lines = json['reports'].map {|r| r['date'] + ' -- ' + r['description']}
    lines.join "\n"
  end
  
end

# Register your handler
Bototo.register PrivateStatusHandler
```

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
