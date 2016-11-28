module WatsonTtsAsrClient
  require 'websocket-client-simple'
  require 'active_support/core_ext/string/inflections'

  class WebsocketClient
    def self.default_options 
      @default_options ||= {
        tts_url:          'wss://stream.watsonplatform.net/text-to-speech/api/v1/synthesize',
        asr_url:          '',
        watson_token:     '',
        voice:            'en-US_AllisonVoice',
        customization_id: '',
        learning_opt_out: 'true'
      }
    end

    attr_reader :options, :api_url

    def initialize(type, options = {})
      @type = type
      @options = self.class.default_options.deep_merge(options)
    end

    def callout(sendable_text)
      ws = Websocket::Client::Simple.connect @options.tts_api_url
      message = ''
      audio_stream = nil
      ws.on :message do |msg|
        if msg.data.is_a? String
          message << msg.data
        else
          puts "Recieved #{message.data.size()} binary bytes"
          audio_stream << msg.data
        end
      end

      ws.on :open do |event|
        initial_message = [text: sendable_text, accept: '*/*' ].to_json
        ws.send initial_message
      end

      ws.on :close do |event|
        puts "--websocket closed"
      end

      ws.on :error do |event|
        puts "--error occured"
      end
    end
  end
end