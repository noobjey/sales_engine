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

  def merchant
    repository.find_merchant_by_id(merchant_id)
  end

  def invoice_items
    repository.find_invoice_items_by_id(id)
  end

  # best_day returns the date with the most sales for the given item using the invoice date
  def best_day
    quantity_per_day = invoice_items.inject(Hash.new(0)) { |h, invoice_item| h[invoice_item.invoice.created_at.strftime("%F")] += invoice_item.quantity; h }
    best_day = quantity_per_day.sort_by { |k, v| v }.reverse.first.first
    Date.parse(best_day)
  end

  private

  def quantity_sold
    invoice_items.inject(0) { |total, invoice_item| total + invoice_item.quantity }
  end
end
