module EchoServer
  require 'websocket-eventmachine-server'

  def self.start
    WebSocket::EventMachine::Server.start(:host => "0.0.0.0", :port => self.port) do |ws|
      @channel = EM::Channel.new
      ws.onopen do
        sid = @channel.subscribe do |mes|
          ws.send mes  # echo to client
        end
        ws.onmessage do |msg|
          @channel.push msg
        end
        ws.onclose do
          @channel.unsubscribe sid
        end
      end
    end
  end

  def self.port
    (ENV['WS_PORT'] || 18080).to_i
  end

  def self.url
    "ws://localhost:#{self.port}"
  end
end

module EchoServerASR
  require 'websocket-eventmachine-server'

  def self.start
    WebSocket::EventMachine::Server.start(:host => "0.0.0.0", :port => self.port) do |ws|
      @channel = EM::Channel.new
      ws.onopen do
        #send audio response code
        ws.send({ state: "listening" }.to_json)
        sid = @channel.subscribe do |mes|
        end
        ws.onmessage do |msg, type|
          ws.send msg, type: type
        end
        ws.onclose do
          @channel.unsubscribe sid
        end
      end
    end
  end

  def self.port
    (ENV['WS_PORT'] || 18080).to_i
  end

  def self.url
    "ws://localhost:#{self.port}"
  end
end