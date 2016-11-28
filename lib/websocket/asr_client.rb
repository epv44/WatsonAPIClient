require 'websocket/websocket_client'

module WatsonTtsAsrClient
  class AsrClient < WebsocketClient
    def initialize(serialized_audio, websocket_client)
      @serialized_audio = serialized_audio
      @websocket_client = websocket_client
    end

    def process_audio
      @websocket_client.callout
    end
  end
end