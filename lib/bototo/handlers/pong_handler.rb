Bototo.register do
  
  on 'ping' do |value|
    say "@#{user[:name]}: pong #{value}"
  end
  
end

# module Bototo
#   module Handlers
# 
#     class PongHandler < Bototo::Handlers::Base
# 
#       on 'ping' do |value|
#         room.speak "@#{user[:name]}: pong #{value}"
#       end
# 
#     end
# 
#   end
# end