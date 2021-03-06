require_relative 'transaction'
require_relative 'load_file'

class TransactionRepository
  attr_reader :sales_engine
  attr_accessor :transactions

  include LoadFile

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @transactions = []
  end

  def load_data(path)
    file          = load_file(path)
    @transactions = file.map do |line|
      Transaction.new(line, self)
    end
  end

  def inspect
    "#<#{self.class} #{transactions.size} rows>"
  end

  def all
    transactions
  end

  def random
    transactions[Random.new.rand(transactions.size)]
  end

  def create(input, invoice_id)

    information = {
      id:                          next_id,
      invoice_id:                  invoice_id,
      credit_card_number:          input[:credit_card_number],
      credit_card_expiration_date: input[:credit_card_expiration_date],
      result:                      input[:result],
      created_at:                  Date.today.strftime,
      updated_at:                  Date.today.strftime,
    }

    new_transaction = Transaction.new(information, self)
    transactions << new_transaction
    new_transaction
  end

  def find_by_id(id)
    transactions.find { |transaction| transaction.id.eql?(id) }
  end

  def find_by_invoice_id(invoice_id)
    transactions.find { |transaction| transaction.invoice_id.eql?(invoice_id) }
  end

  def find_by_credit_card_number(credit_card_number)
    transactions.find do |transaction|
      transaction.credit_card_number.eql?(credit_card_number)
    end
  end

  def find_by_credit_card_expiration_date(credit_card_expiration_date)
    transactions.find do |transaction|
      transaction.credit_card_expiration_date.eql?(credit_card_expiration_date)
    end
  end

  def find_by_result(result)
    transactions.find { |transaction| transaction.result.eql?(result) }
  end

  def find_by_created_at(created_at)
    transactions.find { |transaction| transaction.created_at.eql?(created_at) }
  end

  def find_by_updated_at(updated_at)
    transactions.find { |transaction| transaction.updated_at.eql?(updated_at) }
  end

  def find_all_by_id(id)
    transactions.find_all { |transaction| transaction.id.eql?(id) }
  end

  def find_all_by_invoice_id(invoice_id)
    transactions.find_all do |transaction|
      transaction.invoice_id.eql?(invoice_id)
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    transactions.find_all do |transaction|
      transaction.credit_card_number.eql?(credit_card_number)
    end
  end

  def find_all_by_credit_card_expiration_date(credit_card_expiration_date)
    transactions.find_all do |transaction|
      transaction.credit_card_expiration_date.eql?(credit_card_expiration_date)
    end
  end

  def find_all_by_result(result)
    transactions.find_all { |transaction| transaction.result.eql?(result) }
  end

  def find_all_by_created_at(created_at)
    transactions.find_all do |transaction|
      transaction.created_at.eql?(created_at)
    end
  end

  def find_all_by_updated_at(updated_at)
    transactions.find_all do |transaction|
      transaction.updated_at.eql?(updated_at)
    end
  end

  # Upstream
  def find_invoice_by_invoice_id(invoice_id)
    sales_engine.find_invoice_by_id(invoice_id)
  end

  private

  def next_id
    return 1 if transactions.empty?
    transactions.sort_by { |transaction| transaction.id }.reverse.first.id + 1
  end

end
