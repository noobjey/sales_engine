require_relative 'merchant'
require 'bigdecimal'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  attr_accessor :repository

  def initialize(line, repository)
    @id          = line[:id].to_i
    @name        = line[:name]
    @description = line[:description]
    @unit_price  = BigDecimal.new(line[:unit_price])/100
    @merchant_id = line[:merchant_id].to_i
    @created_at  = line[:created_at]
    @updated_at  = line[:updated_at]
    @repository  = repository
  end

  def merchant(id)
    repository.find_merchant_by_id(id)
  end

  def invoice_items(id)
    repository.find_invoice_items_by_id(id)
  end
end
