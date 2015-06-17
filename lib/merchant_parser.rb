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
    name_position = 1
    created_at_postion = 2
    updated_at_position = 3

    result = csv.map do |row|
      Merchant.new(row[id_position], row[name_position], row[created_at_postion], row[updated_at_position])
    end

    result
  end
end
