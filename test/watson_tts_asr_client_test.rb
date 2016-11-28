require 'test_helper'

class WatsonTtsAsrClientTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::WatsonTtsAsrClient::VERSION
  end
end
