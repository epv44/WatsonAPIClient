require 'test_helper'
require 'echo_server'

class WebsocketClientConfigTest < Minitest::Test
  def test_default_options_are_set
    option = :tts_url
    ws_client = WatsonTtsAsrClient::WebsocketClient.new(option, WatsonTtsAsrClient::AuthorizationClient.new(option))
    assert_equal ws_client.options[option].to_s, 'wss://stream.watsonplatform.net/text-to-speech/api/v1/synthesize'
  end

  def test_default_options_are_set_on_load
    option = :tts_url
    ws_client = WatsonTtsAsrClient::WebsocketClient.new(option, 
      WatsonTtsAsrClient::AuthorizationClient.new(option), 
      {asr_url: 'wss'})
    assert_equal ws_client.options[:asr_url].to_s, 'wss'
  end

  def test_default_options_set_on_config
    WatsonTtsAsrClient::WebsocketClient.default_options[:username] = '1234'
    ws_client = WatsonTtsAsrClient::WebsocketClient.new(:tts, 
      WatsonTtsAsrClient::AuthorizationClient.new(:tts))

    assert_equal ws_client.options[:username], '1234'
  end

  def test_default_options_nested_settings
    WatsonTtsAsrClient::WebsocketClient.default_options[:credentials] = { tts_url: { username: 'tts_name', password: 'tts_password' }, asr_url: { username: 'asr_name', password: 'asr_password' }}
    ws_client = WatsonTtsAsrClient::WebsocketClient.new(:tts_url, 
      WatsonTtsAsrClient::AuthorizationClient.new(:tts_url))
    assert_equal ws_client.options[:credentials][:tts_url][:username], 'tts_name'
    assert_equal ws_client.options[:credentials][:asr_url][:username], 'asr_name'
  end
end
