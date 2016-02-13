module Lita
  module Handlers
    class Doge < Handler
      config :default_words

      ADJ = [
        'such',
        'so',
        'very',
        'much'
      ]

      WORDS = [
        'wow',
        'doge',
        'tasty',
        'groovy'
      ]

      DEFAULT_WORDS = [
        'lita',
        'bot'
      ]

      BASE_URL = 'http://dogr.io/'

      route(/^doge\s*(.*)$/, :doge, command: true)

      def doge(r)
        args = extract_args(r.matches)

        if args.empty?
          r.reply(build_such_wow(config.default_words || DEFAULT_WORDS))
        else
          r.reply(build_such_wow(args))
        end
      end

      private

      def extract_args(matches)
        if matches[0].empty?
          []
        else
          matches[0][0].split
        end
      end

      def build_such_wow(words)
        BASE_URL + WORDS.sample + '/' +
          words.map do |word|
            ADJ.sample + '%20' + word
          end.join('/') +
          '.png?split=false'
      end

      Lita.register_handler(self)
    end
  end
end
