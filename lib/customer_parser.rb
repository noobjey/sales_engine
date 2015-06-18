require_relative 'customer'

class CustomerParser
  attr_reader :data_location

  def initialize(dataset_location)
    @data_location = dataset_location
  end

  def parse
    csv                 = CSV.open(data_location, headers: true)
    id_position         = 0
    first_name_position = 1
    last_name_position  = 2
    created_at_postion  = 3
    updated_at_position = 4

    result = csv.map do |row|
      Customer.new(
        row[id_position],
        row[first_name_position],
        row[last_name_position],
        row[created_at_postion],
        row[updated_at_position]
      )
    end

    result
  end
end
