class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(line)
    @id = line[:id]  .to_i
    @name        = line[:name]
    @description = line[:description]
    @unit_price  = line[:unit_price]
    @merchant_id = line[:merchant_id]
    @created_at  = line[:created_at]
    @updated_at  = line[:updated_at]
  end
end
