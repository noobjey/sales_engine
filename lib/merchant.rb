require 'date'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository

  attr_accessor :items_sold

  def initialize(line, repository)
    @id         = line[:id].to_i
    @name       = line[:name]
    @created_at = Date.parse(line[:created_at])
    @updated_at = Date.parse(line[:updated_at])
    @repository = repository
    @items_sold = 0
  end

  def items
    repository.find_items(id)
  end

  def invoices
    repository.find_invoices_by_id(id)
  end

  def revenue(date = nil)
    if date.nil?
      calculate_revenue(self.invoices)
    else
      calculate_revenue(find_all_invoices_for_date(date, self.invoices))
    end
  end

  def customers_with_pending_invoices
      invoices.map do |invoice|
        invoice.customer unless has_successful_transactions?(invoice)
    end.compact
  end

  def favorite_customer
    successful = find_successful_transactions(self.invoices)
    freq       = successful.inject(Hash.new(0)) do |h, invoice|
      h[invoice.customer_id] += 1; h
    end
    successful.find do |invoice|
      invoice.customer_id == freq.max_by { |key, value| value }.first
    end.customer
  end

  def successful_invoices(invoices)
    find_successful_transactions(invoices)
  end

  def total_items_sold
    successful_invoices = self.successful_invoices(self.invoices)
    successful_inv_items = successful_invoices.map do |invoice|
      invoice.invoice_items
    end.flatten
    self.items_sold = successful_inv_items.inject(0) do |total, invoice_item|
      total + (invoice_item.quantity)
    end
  end

  private

  def calculate_revenue(invoices)
    total(get_invoice_items(find_successful_transactions(invoices)))
  end

  def total(invoice_items)
    invoice_items.inject(0) do |total, invoice_item|
      total + (invoice_item.unit_price * invoice_item.quantity)
    end
  end

  def get_invoice_items(transactions)
    transactions.map { |invoice| invoice.invoice_items }.flatten
  end

  def find_successful_transactions(invoices)
    invoices.find_all { |invoice| has_successful_transactions?(invoice) }
  end

  def has_successful_transactions?(invoice)
    invoice.transactions.any? do |transaction|
      transaction.result.eql?('success')
    end
  end

  def find_all_invoices_for_date(date, invoices)
    invoices.find_all { |invoice| invoice.created_at.eql?(date) }
  end
end


