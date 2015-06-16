require_relative 'test_helper'

class MerchantRepositoryTest < Minitest::Test
  def test_it_stores_data_location
    data_location = "merchants.csv"
    mr = MerchantRepository.new(data_location)

    assert data_location, mr.data_location
  end

  def test_it_passes_data_location_to_parser
    data_location = "merchants.csv"
    mr = MerchantRepository.new(data_location)

    assert data_location, mr.parser.data_location
  end

  def test_it_has_a_merchant_parser
    mr = MerchantRepository.new("merchants.csv")

    merchant_parser = mr.parser

    assert merchant_parser.is_a?(MerchantParser)
  end
  def test_acceptance
    skip
    data_location = "merchants.csv"
    mr = MerchantRepository.new(data_location)
    merchant = Merchant.new
    expected = [merchant]

    result = mr.get_data

    assert_equal expected, result
  end
end
