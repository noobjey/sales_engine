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
    @created_at = convert_date(line[:created_at])
    @updated_at = convert_date(line[:updated_at])
    @repository = repository
  end

  def convert_date(date)
    return 'No Date' if date.nil?
    date.is_a?(Date) ? date : Date.parse(date)
  end

  def invoice
    repository.find_invoice_by_id(invoice_id)
  end

  def item
    repository.find_item_by_id(item_id)
  end
end
