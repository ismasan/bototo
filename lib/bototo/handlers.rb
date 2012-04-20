module Bototo
  
  module Handlers

    def self.handlers
      @handlers ||= []
    end

    def self.register(handler_klass = nil, &block)
      if !handler_klass && block_given? # registering anonymous block
        handler_klass = Class.new(Base, &block)
      end
      handlers << handler_klass
      handlers.uniq!
    end

    def self.find_with(body)
      instances = []
      handlers.each do |klass|
        klass.commands.keys.each do |cmd|
          exp = cmd.kind_of?(Regexp) ? cmd : %r{^#{cmd}(.*)?}
          if match = body.match(exp)
            instances << klass.new(cmd, match[1..match.size])
          end
        end
      end
      instances
    end

    class Base

      attr_reader :room, :message, :user, :matched_command, :matches

      def initialize(matched_command, matches)
        @matched_command, @matches = matched_command, matches.map{|m| m.to_s.strip}
      end
      
      def say(text, &block)
        room.speak text, &block
      end
      
      def paste(text, &block)
        room.paste text, &block
      end

      def self.command(*cmds)
        if cmds.any?
          cmds.each do |cmd|
            commands[cmd] = nil
          end
          Handlers.register self
        end
      end

      def self.on(cmd, &block)
        commands[cmd] = block
      end

      def self.commands
        @commands ||= {}
      end

      def run(room, user, message)
        @room, @user, @message = room, user, message
        if block = self.class.commands[matched_command]
          instance_exec *matches, &block
        end
      end

      protected

      # Some utilities
      def get_json(url, options = {}, &block)
        options[:head] ||= {}
        options[:head]['Accept'] = 'application/json'
        EM::HttpRequest.new(url).get(options).callback { |http|
          begin
            if http.response_header.status.to_s =~ /^20/
              json = MultiJson.decode(http.response)
              block.call json
            else
              p [:request, url, http.response_header.status]
            end
          rescue MultiJson::DecodeError => boom
            p [:error, (URL + "&q=#{value.strip}"), boom.message, http.response]
          end
        }
      end

      def post(url, opts = {}, &block)
        EM::HttpRequest.new(url).post(opts).callback { |http|
          if http.response_header.status.to_s =~ /^20/
            block.call http
          else
            room.speak "Error: #{http.response}"
          end
        }
      end

    end

  end
  
end