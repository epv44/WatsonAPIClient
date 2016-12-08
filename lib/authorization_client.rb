module WatsonTtsAsrClient
  require 'net/http'
  require 'EVHttp/http_client'

  class AuthorizationClient

    def initialize(service_type, http_client = WatsonTtsAsrClient::HttpClient)
      @service_type = service_type
      @url_options = WatsonTtsAsrClient::WebsocketClient.default_options
      @http_client = http_client
    end

    def authorize
      return get_token if has_valid_token
      response = @http_client.get(construct_uri, @url_options[:credentials][@service_type][:username], @url_options[:credentials][@service_type][:password])
      save_token(response.body)
      response.body
    end
    
    private
    def construct_uri
      token_uri = URI(@url_options[@service_type][0...@url_options[@service_type].index(/v1/)])
      token_uri.scheme = "https"
      URI("#{@url_options[:authorization_url]}api/v1/token?url=#{token_uri.to_s}")
    end
    
    def has_valid_token
      false
      #WatsonApi.find(username: @username) 
      #return token.timestamp < 1hr
    end

    def get_token
      #WatsonApi.find(username: @username)
    end

    def save_token(token)
      #WatsonApi.save(username: @username, token: token)
    end
  end
end