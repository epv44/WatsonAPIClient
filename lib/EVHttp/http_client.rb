module WatsonTtsAsrClient
  require 'net/http'
  class HttpClient
    def self.get(uri, username = nil, password = nil)
      request = Net::HTTP::Get.new(uri)
      
      if !username.nil? && !password.nil?
        request.basic_auth(username, password)
      end
      
      response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https'){ |http|
        http.request(request)
      }
      
      response
    end
  end
end