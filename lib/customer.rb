require 'date'

class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :repository

  attr_accessor :items_purchased

  def initialize(line, repository)
    @id         = line[:id].to_i
    @first_name = line[:first_name]
    @last_name  = line[:last_name]
    @created_at = Date.parse(line[:created_at])
    @updated_at = Date.parse(line[:updated_at])
    @repository = repository
    @items_purchased
  end

  def invoices
    repository.find_invoices_by_customer_id(id)
  end

  def transactions
    self.invoices.map { |invoice| invoice.transactions }.flatten
  end

  def favorite_merchant
    repository.find_merchant_by_merchant_id(favorite_merchant_id)
  end

  def successful_invoices(invoices)
    find_successful_transactions(invoices)
  end

  def total_items_purchased
    successful_invoices = self.successful_invoices(self.invoices)
    successful_inv_items = successful_invoices.map do |invoice|
      invoice.invoice_items
    end.flatten
    self.items_purchased = successful_inv_items.inject(0) do |total, invoice_item|
      total + (invoice_item.quantity)
    end
  end

  def total_money_spent
    calculate_total_money_spent(self.invoices)
  end

  # def days_since_activity
  #   transactions.sort_by do |transaction|
  #     # require 'pry'; binding.pry
  #     transaction.created_at
  #   end
  # end

  private

  def calculate_total_money_spent(invoices)
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

  def transactions_per_merchant
    transactions.inject(Hash.new(0)) do |h, transaction|
      h[transaction.invoice.merchant_id] += 1; h
    end
  end

  def favorite_merchant_id
    transactions_per_merchant.sort_by { |k, v| v }.reverse.first.first
  end

  def find_successful_transactions(invoices)
    invoices.find_all { |invoice| has_successful_transactions?(invoice) }
  end

  def has_successful_transactions?(invoice)
    invoice.transactions.any? do |transaction|
      transaction.result.eql?('success')
    end
  end
end
