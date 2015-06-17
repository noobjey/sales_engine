require 'csv'
require_relative 'merchant_repository'
require_relative 'merchant_parser'

class SalesEngine
  attr_reader :merchant_data_location,
              :merchant_repository,
              :merchant_parser

  def initialize(merchant_data_location = "./data/merchants.csv")
    @merchant_data_location = merchant_data_location
    @merchant_parser = MerchantParser.new(merchant_data_location)
  end

  def startup
    @merchant_repository = MerchantRepository.new(merchant_parser.parse)
  end

end

