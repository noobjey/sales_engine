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

  def best_day
    quantity_per_day = invoice_items.inject(Hash.new(0)) do |h, invoice_item|
      formatted_date = invoice_item.invoice.created_at.strftime("%F")
      h[formatted_date] += invoice_item.quantity;
      h
    end

    best_day         = quantity_per_day.sort_by { |k, v| v }.reverse.first.first
    Date.parse(best_day)
  end

  def quantity_sold
    invoice_items.inject(0) do |total, invoice_item|
      total + invoice_item.quantity
    end
  end

  def revenue
    invoice_items.inject(0) do |total, invoice_item|
      invoice_item_total = 0

      if has_successful_transactions?(invoice_item.invoice)
        invoice_item_total = (invoice_item.unit_price * invoice_item.quantity)
      end

      total + invoice_item_total
    end
  end

  private

  def has_successful_transactions?(invoice)
    invoice.transactions.any? do |transaction|
      transaction.result.eql?('success')
    end
  end
end
