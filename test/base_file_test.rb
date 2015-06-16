require 'minitest/autorun'
require 'minitest/pride'

require './lib/base_file'

class BaseFileTest < Minitest::Test
  def test_it
    assert !!BaseFile.new
    refute !!!BaseFile.new
  end
end
