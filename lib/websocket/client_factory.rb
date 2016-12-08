module WatsonTtsAsrClient
  class ClientFactory
    def initialize(data, websocket_client)
      @data = data
      @websocket_client = websocket_client
    end

    def process
      the_result = nil
      @websocket_client.callout(format_msg, @data) do |result|
        STDERR.puts "My result is: #{result.get_json}"
        STDERR.puts "REsult data: #{result.data}"
        the_result = result
      end
      return the_result
    end

    def format_msg
      #sending audio data or sending text
      if @data.encoding.name == "ASCII-8BIT"
        return ({ action: "start", :"content-type"=>"audio/l16;rate=22050" }.to_json)
      elsif @data.encoding.name == "UTF-8"
        return ({ text: @data, accept: "audio/wav "}.to_json ) 
      else
        raise ArgumentError, "Invalid encoding for #{@data} with encoding: #{@data.encoding}"
      end
    end
  end
end