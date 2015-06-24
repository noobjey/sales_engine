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
    @unit_price = BigDecimal.new(line[:unit_price])/100
    @created_at = line[:created_at]
    @updated_at = line[:updated_at]
    @repository = repository
  end
end
