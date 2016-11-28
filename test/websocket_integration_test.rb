require 'test_helper'

class WebsocketIntegrationTest < Minitest::Test
  def test_tts_flow
    WatsonTtsAsrClient::WebsocketClient.default_options[:watson_token] = ENV["token"]
    WatsonTtsAsrClient::WebsocketClient.default_options[:customization_id] = ENV["customization_id"]
    
    WatsonTtsAsrClient::WatsonClientFacade.process("my name is steve")

  end
end