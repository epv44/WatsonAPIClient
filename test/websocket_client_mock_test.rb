require 'test_helper'
require 'echo_server'

class WebsocketClientMockTest < Minitest::Test

  def setup
    WebMock.allow_net_connect!
  end

  def test_send_recieve_message
    response = nil

    EM::run {
      EchoServer.start

      EM::add_timer 1 do
        option = :tts_url
        initial_message = { text: "This is Sparta", accept: "audio/wav" }.to_json 
        data = nil
        connection_url = EchoServer.url
        client = WatsonTtsAsrClient::WebsocketClient.new(option, WatsonTtsAsrClient::AuthorizationClient.new(option))
        client.callout(initial_message, data, connection_url) do |resp|
          response = resp
        end
        EM::add_timer 3 do
          EM::stop_event_loop
        end
      end
    }

    assert_equal response.get_json.text, "This is Sparta"
  end

  def test_send_recieve_audio
    response = nil
    data = File.binread('sample/test_audio.wav')

    EM::run {
      EchoServerASR.start

      EM::add_timer 1 do
        option = :asr_url
        initial_message = { action: "start", 'content-type': "audio/l16" }.to_json
        connection_url = EchoServerASR.url
        client = WatsonTtsAsrClient::WebsocketClient.new(option, WatsonTtsAsrClient::AuthorizationClient.new(option))
        client.callout(initial_message, data, connection_url) do |resp|
          response = resp
        end
        EM::add_timer 3 do
          EM::stop_event_loop
        end
      end
    }
    assert_equal response.data.encoding.name == "ASCII-8BIT", true
  end
end