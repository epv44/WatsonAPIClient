module WatsonTtsAsrClient
  require 'websocket-eventmachine-client'
  require 'json'
  require 'active_support/core_ext/string/inflections'

  class WebsocketClient
    def self.default_options 
      @default_options ||= {
        tts_url:           'wss://stream.watsonplatform.net/text-to-speech/api/v1/synthesize',
        asr_url:           'wss://stream.watsonplatform.net/speech-to-text/api/v1/recognize',
        authorization_url: 'https://stream.watsonplatform.net/authorization/',
        voice:             'en-US_AllisonVoice',
        customization_id:  '',
        learning_opt_out:  'true',
        credentials:       { tts_url: { username: '', password: '' }, asr_url: { username: '', password: '' }}
      }
    end
    #max size allowed by ibm is 4 million bytes
    def self.chunk_size
      3_000_000_000
    end

    attr_reader :options, :api_url

    def initialize(type, auth_client, options = {})
      @type = type
      @options = self.class.default_options.deep_merge(options)
      @auth_client = auth_client
    end

    #who wrote this method AHHHHH
    def callout(initial_msg, data = nil, connection_url = nil)
      token = @auth_client.authorize
      STDERR.puts "Type for the url group: #{@type}"
      connection_url ||= "#{@options[@type]}?watson-token=#{token}"
      response = WatsonTtsAsrClient::Model::SocketResponse.new()
      file_sent = false
      
      EM.run do
        trap("TERM") { stop }
        trap("INT")  { stop }
        ws = WebSocket::EventMachine::Client.connect(:uri => connection_url)
        ws.onopen do
          #or send binary data...
          ws.send(initial_msg)
        end
        #this is awful, I can't believe I wrote it, fuck...fix this!!!!
        ws.onmessage do |msg, type|
          STDERR.puts "response #{msg}"
          if @type == :tts_url
            if type == :text
              response.set_json(msg)
              #should probably find a way to pass this in as a block eventually
              #if response is { "state" : "listening" } send audio file
            elsif type == :binary
              response.data << msg
            else
              STDERR.puts "~~Error recieved other message: #{message} of type: #{type}"
            end
          else
            if type == :text
              res = JSON.parse(msg, object_class: OpenStruct)
              if res.respond_to?(:state) && res.state == "listening"
                if file_sent == true
                  yield response
                  stop 
                end
                data.bytes.each_slice(WebsocketClient.chunk_size) { |chunk| ws.send(chunk.pack("C*"), type: :binary) }
                ws.send("", type: :binary)
                file_sent = true
              elsif res.respond_to?(:results)
                STDERR.puts "responds to results"
                response.set_json(msg)
              else
                STDERR.puts "It does not respond to listening"
              end
            elsif type == :binary
              response.data << msg
            end
          end
        end

        ws.onclose do |code, reason|
          STDERR.puts "Disconnected with status code: #{code}"
          yield response
          stop
        end

        ws.onping do |msg|
          STDERR.puts "Recevied ping: #{msg}"
        end

        ws.onpong do |msg|
          STDERR.puts "Received pong: #{msg}"
        end

        ws.onerror do |e|
          STDERR.puts "Error in websocket connection to IBM: #{e}"
          STDERR.puts "For url: #{connection_url}"
          yield e
          stop
        end

        def stop
          EventMachine.stop_event_loop
        end
      end
    end
  end
end