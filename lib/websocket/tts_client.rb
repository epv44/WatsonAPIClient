module WatsonTtsAsrClient
  class TtsClient < WebsocketClient

    def initialize(text, websocket_client)
      @text = text
      @websocket_client = websocket_client
    end

    def process_text
      @websocket_client.callout(@text)
    end
  end
end
