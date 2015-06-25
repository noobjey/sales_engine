class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :repository

  def initialize(line, repository)
    @id         = line[:id].to_i
    @first_name = line[:first_name]
    @last_name  = line[:last_name]
    @created_at = line[:created_at]
    @updated_at = line[:updated_at]
    @repository = repository
  end

  def invoices
    repository.find_invoices_by_customer_id(id)
  end

  def transactions
    self.invoices.map { |invoice| invoice.transactions }.flatten
  end

  def favorite_merchant
    transactions_per_merchant = transactions.inject(Hash.new(0)) do |h, transaction|
      h[transaction.invoice.merchant_id] += 1; h
    end
    favorite_merchant_id = transactions_per_merchant.sort_by do |k, v|
      v
    end.reverse.first.first
    repository.find_merchant_by_merchant_id(favorite_merchant_id)
  end
end
