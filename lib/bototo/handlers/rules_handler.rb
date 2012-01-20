module Bototo
  module Handlers

    class RulesHandler < Base
      RULES = [
        "1. A robot may not injure a human being or, through inaction, allow a human being to come to harm.",
        "2. A robot must obey any orders given to it by human beings, except where such orders would conflict with the First Law.",
        "3. A robot must protect its own existence as long as such protection does not conflict with the First or Second Law."
      ]

      on 'show me the rules' do |value|
        say RULES.join("\n")
      end
    end
    
    Bototo.register RulesHandler
    
  end
  
end