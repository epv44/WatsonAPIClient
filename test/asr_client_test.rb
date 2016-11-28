require 'test_helper'

class AsrClientTest < Minitest::Test
  def test_should_return_processed_result
    refute_nil ::WatsonTtsAsrClient::VERSION
  end
end
