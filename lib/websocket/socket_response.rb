module WatsonTtsAsrClient
  module Model
    require 'json'
    class SocketResponse
      attr_accessor :data
      def initialize (data = nil, json = nil)
        @data = data.nil? ? '' : data
        @json = json
      end

      def set_json(json)
        @json = JSON.parse(json, object_class: OpenStruct)
      end

      def get_json
        @json
      end
    end
  end
end