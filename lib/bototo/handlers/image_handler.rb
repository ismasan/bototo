require 'cgi'

module Bototo
  module Handlers

    class ImageHandler < Base

      URL = 'http://ajax.googleapis.com/ajax/services/search/images?v=1.0&rsz=8'
      URL_REGEXP = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix

      on 'image me' do |value|
        get_url(value) do |url|
          say url
        end
      end

      on 'mustache me' do |value|
        get_url(value) do |url|
          say "http://mustachify.me/?src=#{url}"
        end
      end

      protected

      def get_url(value, &block)
        if value =~ URL_REGEXP
          block.call value
        else # not a url. Look up in google images
          get_json(URL, :query => {:q => CGI.escape(value)}) do |json|
            block.call json['responseData']['results'].first['unescapedUrl']
          end
        end
      end

    end

  end
end