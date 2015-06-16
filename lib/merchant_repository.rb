require_relative 'merchant'
require_relative 'merchant_parser'

class MerchantRepository
  attr_reader :data_location,
              :parser

  def initialize(data_location)
    @data_location = data_location
    @parser = MerchantParser.new(@data_location)
  end

  def merchants
    [Merchant.new]
  end

  def get_data

  end
end
