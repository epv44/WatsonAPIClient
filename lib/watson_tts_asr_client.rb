require 'watson_tts_asr_client/version'
require 'websocket/client_factory'
require 'websocket/websocket_client'
require 'EVHttp/http_client'
require 'authorization_client'
require 'websocket/socket_response'

module WatsonTtsAsrClient
  class WatsonClientFacade
    def self.process(data)
      service_type = data.encoding.name == "ASCII-8BIT" ? :asr_url : :tts_url
      client = WatsonTtsAsrClient::ClientFactory.new(data, 
        WatsonTtsAsrClient::WebsocketClient.new(service_type, AuthorizationClient.new(service_type)))
      client.process
    end
  end
end
