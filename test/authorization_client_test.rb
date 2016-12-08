require 'test_helper'

class ClientFactoryTest < Minitest::Test
  def setup
    WatsonTtsAsrClient::WebsocketClient.default_options[:credentials] = { tts_url: { username: 'tts_name', password: 'tts_password' }, asr_url: { username: 'asr_name', password: 'asr_password' }}
    
  end

  def test_authorize_with_httpmock
    stub_request(:get, "https://stream.watsonplatform.net/authorization/api/v1/token?url=https://stream.watsonplatform.net/text-to-speech/api/")
      .with(basic_auth: ['tts_name', 'tts_password'])
      .to_return(status: 200, body: "token_value")
    auth_client = WatsonTtsAsrClient::AuthorizationClient.new(:tts_url)
    response = auth_client.authorize()
    assert_equal response, "token_value"
  end
end