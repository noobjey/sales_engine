require_relative 'test_helper'

class MerchantRepositoryTest < Minitest::Test
  def test_it_stores_data_location
    data_location = "merchants.csv"
    mr = MerchantRepository.new(data_location)

    assert data_location, mr.data_location
  end
end
