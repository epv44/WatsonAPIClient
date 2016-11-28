require 'watson_tts_asr_client/version'
require 'websocket/asr_client'
require 'websocket/tts_client'
require 'websocket/websocket_client'

module WatsonTtsAsrClient
  class WatsonClientFacade
    def self.process(data)
      if data.string?
        tts = TtsClient.new(data, WebsocketClient.new('tts'))

        return tts.process
      elsif data.file?
        asr = AsrClient.new(data, WebsocketClient.new('asr'))

        return asr.process
      else
        raise ArgumentError, "Incorrect data passed to the facade"
      end 
    end
  end
end
