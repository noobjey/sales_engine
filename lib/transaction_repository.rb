require_relative 'transaction'

class TransactionRepository
  attr_reader :transactions

  def initialize(transactions)
    @transactions = transactions
  end

  def inspect
    "#<#{self.class} #{transactions.size} rows>"
  end
end
