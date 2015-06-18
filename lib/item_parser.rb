class ItemParser
  attr_reader :data_location

  def initialize(data_location)
    @data_location = data_location
  end

  def parse
    csv                  = CSV.open(data_location, headers: true)
    id_position          = 0
    name_position        = 1
    description_postion  = 2
    unit_price_position  = 3
    merchant_id_position = 4
    created_at_position  = 5
    updated_at_postion   = 6


    result = csv.map do |row|
      Item.new(
        row[id_position],
        row[name_position],
        row[description_postion],
        row[unit_price_position],
        row[merchant_id_position],
        row[created_at_position],
        row[updated_at_postion]
      )
    end

    result
  end
end
