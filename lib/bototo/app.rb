module Bototo
  
  class App
    
    attr_reader :config, :connection
    
    def initialize(config)
      @config = config
      @connection = Firering::Connection.new("http://#{config.subdomain}.campfirenow.com") do |c|
        c.token = config.token
      end
    end
    
    def run!
      
      
      connection.authenticate do |user|
        connection.rooms do |rooms|

          rooms.each do |room|
            if room.name == config.room_name

              room.stream do |message|

                message.user do |user|
                  puts "#{user}: #{message}"

                  if message.text? && message.body =~ %r{^#{config.bot_name}\s+(.+)}
                    handlers = Handlers.find_with($1)
                    if handlers.any?
                      handlers.each do |handler|
                        handler.run(room, user, message)
                      end
                    else
                      room.speak "Shut up, you prick!"
                    end
                  end
                end

              end

            end
          end

        end
      end
      
      
      
    end
    
  end
  
end