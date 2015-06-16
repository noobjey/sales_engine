require_relative 'merchant'

class MerchantRepository
  attr_reader :data_location

  def initialize(data_location)
    @data_location = data_location
  end

  def merchants
    [Merchant.new]
  end
end
