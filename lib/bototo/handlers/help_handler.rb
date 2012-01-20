Bototo.register do
  
  on 'help' do |value|
    lines = Bototo::Handlers.handlers.map do |handler|
      handler.commands.keys
    end.flatten
    paste "** Available commands are ** \n#{ lines.join("\n") }"
  end
  
end
