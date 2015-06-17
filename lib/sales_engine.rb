require 'csv'
require_relative 'merchant_repository'
require_relative 'merchant_parser'
require_relative 'item_repository'
require_relative 'item_parser'

class SalesEngine
  DEFUALT_DATA_LOCATIONS = {
                              merchant: "./data/merchants.csv",
                              item: "./data/items.csv"
                           }

  attr_reader :merchant_data_location,
              :merchant_repository,
              :merchant_parser,
              :item_data_location,
              :item_repository,
              :item_parser

  def initialize(dataset_locations = DEFUALT_DATA_LOCATIONS)
    @dataset_locations = dataset_locations
    @merchant_data_location = dataset_locations[:merchant]
    @merchant_parser = MerchantParser.new(merchant_data_location)
    @item_data_location = dataset_locations[:item]
    @item_parser = ItemParser.new(item_data_location)
  end

  def startup
    @merchant_repository = MerchantRepository.new(merchant_parser.parse)
    @item_repository = ItemRepository.new
  end

end

