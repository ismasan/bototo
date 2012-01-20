Bototo.register do
  
  on 'ping' do |value|
    say "@#{user[:name]}: pong #{value}"
  end
  
end