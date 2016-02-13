require "spec_helper"

describe Lita::Handlers::Doge, lita_handler: true do
  let(:user) { Lita::User.create("1234", name: "skelz0r") }

  let(:registry) do
    reg = Lita::Registry.new

    reg.register_handler(Lita::Handlers::Doge)

    reg.configure do |config|
      config.robot.alias = "!"
      config.handlers.doge.default_words = ['jam', 'students']
    end

    reg
  end

  it { is_expected.to route("!doge") }
  it { is_expected.to route("!doge jam students") }

  describe "such response" do
    before do
      send_message(message, as: user)
    end

    context "without arguments, wow" do
      let(:message) { "!doge" }

      it "generates such messages with default words, so tasty" do
        replies.last.should match(
          /^http:\/\/dogr.io\/.*\/(?:#{Lita::Handlers::Doge::ADJ.join('|')}%20#{Lita::Handlers::Doge::DEFAULT_WORDS.join('|')}).*\.png\?split=false$/
        )
      end
    end

    context "much argument" do
      let(:message) { "!doge thanks tasty" }

      it "generates such messages with arguments, much groovy" do
        replies.last.should match(
          /^http:\/\/dogr.io\/.*\/(?:#{Lita::Handlers::Doge::ADJ.join('|')})%20(?:thanks|tasty).*\.png\?split=false$/
        )
      end
    end
  end
end
