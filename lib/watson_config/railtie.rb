module WatsonConfig
  require 'rails'

  class Railtie < Rails::Railtie
    if app.config.respond_to?(:watson_defaults)
      Websocket::WebsocketClient.default_options.merge!(app.config.watson_defaults)
    end
  end
end