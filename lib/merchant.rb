require 'date'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository,
              :revenue_all,
              :revenue_for_date

  def initialize(line, repository)
    @id         = line[:id].to_i
    @name       = line[:name]
    @created_at = Date.parse(line[:created_at])
    @updated_at = Date.parse(line[:updated_at])
    @repository = repository
  end

  def items
    repository.find_items(id)
  end

  def invoices
    repository.find_invoices_by_id(id)
  end

  def revenue(date = nil)
    if date.nil?
      @revenue_all = calculate_revenue(self.invoices)
      result       = @revenue_all
    else
      @revenue_for_date = calculate_revenue(find_all_invoices_for_date(date))
      result            = @revenue_for_date
    end
    result
  end

  def customers_with_pending_invoices
    invoices.map { |invoice| invoice.customer unless has_successful_transactions?(invoice) }.compact
  end

  private

  def calculate_revenue(invoices)
    total(get_invoice_items(find_successful_transactions(invoices)))
  end

  def total(invoice_items)
    invoice_items.inject(0) { |total, invoice_item| total + (invoice_item.unit_price * invoice_item.quantity) }
  end

  def get_invoice_items(transactions)
    transactions.map { |invoice| invoice.invoice_items }.flatten
  end

  def find_successful_transactions(invoices)
    invoices.find_all { |invoice| has_successful_transactions?(invoice) }
  end

  def has_successful_transactions?(invoice)
    invoice.transactions.any? { |transaction| transaction.result.eql?('success') }
  end

  def find_all_invoices_for_date(date)
    self.invoices.find_all { |invoice| invoice.created_at.eql?(date) }
  end
end


