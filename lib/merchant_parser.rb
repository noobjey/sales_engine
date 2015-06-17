require 'CSV'
require_relative 'merchant'

class MerchantParser
  attr_reader :data_location

  def initialize(data_location)
    @data_location = data_location
  end

  def parse
    csv = CSV.open(data_location, headers: true)
    id_position = 0

    result = csv.map do |row|
      Merchant.new(row[id_position])
    end

    result
  end
end
