require 'csv'
require './lib/merchant_repository'

class SalesEngine
  attr_reader :merchant_data_location,
              :merchant_repository

  def initialize(merchant_data_location = "./data/merchants.csv")
    @merchant_data_location = merchant_data_location
  end

  def startup
    @merchant_repository = MerchantRepository.new(merchant_data_location)
  end

end

