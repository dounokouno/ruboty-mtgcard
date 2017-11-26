require 'ruboty'
require 'open-uri'
require 'json'

module Ruboty
  module Handlers
    class Mtgcard < Base
      API_URL = 'https://api.magicthegathering.io/v1/cards?'
      DEFAULT_MTGCARD_LANGUAGE = 'english'
      DEFAULT_MTGCARD_MESSAGE_WHEN_NOT_FOUND = 'No cards found.'

      env :MTGCARD_LANGUAGE, 'MTG card language (default: english)', optional: true
      env :MTGCARD_MESSAGE_WHEN_NOT_FOUND, 'Message when not found (default: No cards found.)', optional: true

      LANGUAGE = ENV['MTGCARD_LANGUAGE'] || DEFAULT_MTGCARD_LANGUAGE
      MESSAGE_WHEN_NOT_FOUND = ENV['MTGCARD_MESSAGE_WHEN_NOT_FOUND'] || DEFAULT_MTGCARD_MESSAGE_WHEN_NOT_FOUND

      on(
        /(mtgcard) (?<keyword>.+)/,
        name: 'mtgcard',
        description: 'Returns the MTG card illustration URL that matches the keyword'
      )

      def mtgcard(message)
        image_url = nil

        begin
          res = open "#{api_url}&name=#{URI.escape(message[:keyword])}"
        rescue => e
          return message.reply e
        end

        cards = JSON.parse(res.read)['cards']
        return message.reply MESSAGE_WHEN_NOT_FOUND if cards.length == 0

        if LANGUAGE == 'english'
          while image_url.nil? || image_url.length == 0
            image_url = cards.sample['imageUrl']
          end
        else
          while image_url.nil? || image_url.length == 0
            card = cards.sample['foreignNames'].find { |foreig_name| foreig_name['language'] == LANGUAGE.capitalize }
            image_url = card['imageUrl']
          end
        end

        message.reply image_url
      end

      private

      def api_url
        url = API_URL
        url += "language=#{LANGUAGE}" if LANGUAGE != 'english'
        url
      end
    end
  end
end
