require 'bigdecimal'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :repository

  def initialize(line, repository)
    @id         = line[:id].to_i
    @item_id    = line[:item_id].to_i
    @invoice_id = line[:invoice_id].to_i
    @quantity   = line[:quantity].to_i
    @unit_price = convert_unit_price(line[:unit_price])
    @created_at = convert_date(line[:created_at])
    @updated_at = convert_date(line[:updated_at])
    @repository = repository
  end

  def invoice
    repository.find_invoice_by_id(invoice_id)
  end

  def item
    repository.find_item_by_id(item_id)
  end

  private

  def convert_unit_price(unit_price)
    return unit_price if unit_price.is_a?(BigDecimal)
    BigDecimal.new(unit_price)/100
  end

  def convert_date(date)
    return 'No Date' if date.nil?
    date.is_a?(Date) ? date : Date.parse(date)
  end
end
