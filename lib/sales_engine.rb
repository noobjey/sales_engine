require 'csv'
require_relative 'merchant_repository'
require_relative 'merchant_parser'
require_relative 'item_repository'
require_relative 'item_parser'
require_relative 'customer_repository'
require_relative 'customer_parser'

class SalesEngine
  DEFUALT_DATA_LOCATIONS = {
    merchant: "./data/merchants.csv",
    item:     "./data/items.csv",
    customer:  "./data/customers.csv"
  }

  attr_reader :merchant_data_location,
              :merchant_repository,
              :merchant_parser,
              :item_data_location,
              :item_repository,
              :item_parser,
              :customer_data_location,
              :customer_repository,
              :customer_parser

  def initialize(dataset_locations = DEFUALT_DATA_LOCATIONS)
    @merchant_data_location = dataset_locations[:merchant]
    @merchant_parser        = MerchantParser.new(merchant_data_location)
    @item_data_location     = dataset_locations[:item]
    @item_parser            = ItemParser.new(item_data_location)
    @customer_data_location = dataset_locations[:customer]
    @customer_parser        = CustomerParser.new(@customer_data_location)
  end

  def startup
    @merchant_repository = MerchantRepository.new(merchant_parser.parse)
    @item_repository     = ItemRepository.new(item_parser.parse)
    @customer_repository = CustomerRepository.new(customer_parser.parse)
  end

end

