require 'csv'
require './lib/merchant_repository'

class SalesEngine
  attr_reader :merchant_file_name

  def initialize
    @merchant_file_name = "./data/merchants.csv"
  end

  def startup

  end

  def merchant_repository
    MerchantRepository.new(merchant_file_name)
  end
end

