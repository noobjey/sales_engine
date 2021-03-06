require_relative 'test_helper'
require 'date'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :transactions,
              :fake_sales_engine,
              :fixture_path,
              :transaction_input,
              :new_transaction_input,
              :fake_invoice_id

  def setup
    @fake_sales_engine = "fake sales engine"
    @fixture_path      = './data/fixtures/transactions.csv'
    @transaction_input = {
      id:                          1,
      invoice_id:                  1,
      credit_card_number:          '4654405418249632',
      credit_card_expiration_date: '',
      result:                      'success',
      created_at:                  '2012-03-27 14:53:59 UTC',
      updated_at:                  '2012-03-27 14:53:59 UTC'
    }

    transaction1 = Transaction.new(transaction_input, nil)
    transaction2 = Transaction.new(transaction_input, nil)
    transaction3 = Transaction.new(transaction_input, nil)
    transaction4 = Transaction.new(transaction_input, nil)

    @transactions = [transaction1, transaction2, transaction3, transaction4]

    @new_transaction_input = {
      credit_card_number:          '1111222233334444',
      credit_card_expiration_date: "10/14",
      result:                      "success"
    }

    @fake_invoice_id = 12
  end

  def test_it_knows_its_parent
    repo = TransactionRepository.new(fake_sales_engine)

    assert fake_sales_engine, repo.sales_engine
  end

  def test_it_has_transactions
    repo = TransactionRepository.new(fake_sales_engine)

    assert [], repo.transactions
  end

  def test_it_loads_the_data
    repo = TransactionRepository.new(fake_sales_engine)

    repo.load_data(@fixture_path)

    assert_equal 10, repo.transactions.size
    assert_equal 6, repo.transactions[5].id
  end

  def test_it_passes_itself_to_transactions
    path = @fixture_path
    repo = TransactionRepository.new(fake_sales_engine)

    repo.load_data(path)

    assert_equal repo, repo.transactions.first.repository
  end

  def test_all_returns_all_transactions_in_repository
    repo              = TransactionRepository.new(fake_sales_engine)
    expected          = ['array with alot of transactions', 'like two']
    repo.transactions = expected

    assert_equal expected, repo.all
  end

  def test_random_returns_a_random_instance
    repo              = TransactionRepository.new(fake_sales_engine)
    expected          = 10000.times.map { |num| num }
    repo.transactions = expected

    refute repo.random.eql?(repo.random)
    refute repo.random.eql?(repo.random)
  end

  def test_find_by_id
    repo              = TransactionRepository.new(fake_sales_engine)
    repo.transactions = transactions

    assert_equal transaction_input[:id], repo.find_by_id(transaction_input[:id]).id
  end

  def test_find_by_invoice_id
    repo              = TransactionRepository.new(fake_sales_engine)
    repo.transactions = transactions

    assert_equal transaction_input[:invoice_id], repo.find_by_invoice_id(transaction_input[:invoice_id]).invoice_id
  end

  def test_find_by_credit_card_number
    repo              = TransactionRepository.new(fake_sales_engine)
    repo.transactions = transactions

    assert_equal transaction_input[:credit_card_number], repo.find_by_credit_card_number(transaction_input[:credit_card_number]).credit_card_number
  end

  def test_find_by_credit_card_expiration_date
    repo              = TransactionRepository.new(fake_sales_engine)
    repo.transactions = transactions

    assert_equal transaction_input[:credit_card_expiration_date], repo.find_by_credit_card_expiration_date(transaction_input[:credit_card_expiration_date]).credit_card_expiration_date
  end

  def test_find_by_result
    repo              = TransactionRepository.new(fake_sales_engine)
    repo.transactions = transactions

    assert_equal transaction_input[:result], repo.find_by_result(transaction_input[:result]).result
  end

  def test_find_by_created_at
    repo              = TransactionRepository.new(fake_sales_engine)
    repo.transactions = transactions

    assert_equal Date.parse(transaction_input[:created_at]), repo.find_by_created_at(Date.parse(transaction_input[:created_at])).created_at
  end

  def test_find_by_updated_at
    repo              = TransactionRepository.new(fake_sales_engine)
    repo.transactions = transactions

    assert_equal Date.parse(transaction_input[:updated_at]), repo.find_by_updated_at(Date.parse(transaction_input[:updated_at])).updated_at
  end

  def test_find_all_by_id
    repo              = TransactionRepository.new(fake_sales_engine)
    repo.transactions = transactions

    assert_equal 4, repo.find_all_by_id(transaction_input[:id]).size
    assert_equal transaction_input[:id], repo.find_all_by_id(transaction_input[:id]).first.id
  end

  def test_find_all_by_invoice_id
    repo              = TransactionRepository.new(fake_sales_engine)
    repo.transactions = transactions

    assert_equal 4, repo.find_all_by_invoice_id(transaction_input[:invoice_id]).size
    assert_equal transaction_input[:invoice_id], repo.find_all_by_invoice_id(transaction_input[:invoice_id]).first.invoice_id
  end

  def test_find_all_by_credit_card_number
    repo              = TransactionRepository.new(fake_sales_engine)
    repo.transactions = transactions

    assert_equal 4, repo.find_all_by_credit_card_number(transaction_input[:credit_card_number]).size
    assert_equal transaction_input[:credit_card_number], repo.find_all_by_credit_card_number(transaction_input[:credit_card_number]).first.credit_card_number
  end


  def test_find_all_by_credit_card_expiration_date
    repo              = TransactionRepository.new(fake_sales_engine)
    repo.transactions = transactions

    assert_equal 4, repo.find_all_by_credit_card_expiration_date(transaction_input[:credit_card_expiration_date]).size
    assert_equal transaction_input[:credit_card_expiration_date], repo.find_all_by_credit_card_expiration_date(transaction_input[:credit_card_expiration_date]).first.credit_card_expiration_date
  end

  def test_find_all_by_result
    repo              = TransactionRepository.new(fake_sales_engine)
    repo.transactions = transactions

    assert_equal 4, repo.find_all_by_result(transaction_input[:result]).size
    assert_equal transaction_input[:result], repo.find_all_by_result(transaction_input[:result]).first.result
  end

  def test_find_all_by_created_at
    repo              = TransactionRepository.new(fake_sales_engine)
    repo.transactions = transactions

    assert_equal 4, repo.find_all_by_created_at(Date.parse(transaction_input[:created_at])).size
    assert_equal Date.parse(transaction_input[:created_at]), repo.find_all_by_created_at(Date.parse(transaction_input[:created_at])).first.created_at
  end

  def test_find_all_by_updated_at
    repo              = TransactionRepository.new(fake_sales_engine)
    repo.transactions = transactions

    assert_equal 4, repo.find_all_by_updated_at(Date.parse(transaction_input[:updated_at])).size
    assert_equal Date.parse(transaction_input[:updated_at]), repo.find_all_by_updated_at(Date.parse(transaction_input[:updated_at])).first.updated_at
  end

  def test_find_invoice_by_id
    sales_engine = Minitest::Mock.new
    repo         = TransactionRepository.new(sales_engine)

    sales_engine.expect(:find_invoice_by_id, nil, [transaction_input[:invoice_id]])
    repo.find_invoice_by_invoice_id(transaction_input[:invoice_id])

    sales_engine.verify
  end

  def test_new_transaction_knows_its_parent
    repo              = TransactionRepository.new(fake_sales_engine)
    repo.transactions = []

    transaction =repo.create(new_transaction_input, fake_invoice_id)

    assert_equal repo, transaction.repository
  end

  def test_new_transaction_creates_id
    repo                   = TransactionRepository.new(fake_sales_engine)
    last_id                = 35
    transaction_input[:id] = last_id
    repo.transactions      = [Transaction.new(transaction_input, self)]

    transaction = repo.create(new_transaction_input, fake_invoice_id)

    assert_equal last_id.next, transaction.id
  end

  def test_new_transation_has_invoice_id
    repo              = TransactionRepository.new(fake_sales_engine)
    repo.transactions = []

    transaction = repo.create(new_transaction_input, fake_invoice_id)

    assert_equal fake_invoice_id, transaction.invoice_id
  end

  def test_new_transation_has_credit_card_number
    repo              = TransactionRepository.new(fake_sales_engine)
    repo.transactions = []

    transaction = repo.create(new_transaction_input, fake_invoice_id)

    assert_equal new_transaction_input[:credit_card_number], transaction.credit_card_number
  end

  def test_new_transation_has_credit_card_expiration_date
    repo              = TransactionRepository.new(fake_sales_engine)
    repo.transactions = []

    transaction = repo.create(new_transaction_input, fake_invoice_id)

    assert_equal new_transaction_input[:credit_card_expiration_date],
                 transaction.credit_card_expiration_date
  end

  def test_new_transation_has_result
    repo              = TransactionRepository.new(fake_sales_engine)
    repo.transactions = []

    transaction = repo.create(new_transaction_input, fake_invoice_id)

    assert_equal new_transaction_input[:result], transaction.result
  end

  def test_new_transation_has_created_at
    repo              = TransactionRepository.new(fake_sales_engine)
    repo.transactions = []

    transaction = repo.create(new_transaction_input, fake_invoice_id)

    assert_equal Date.parse(Date.today.strftime), transaction.created_at
  end

  def test_new_transation_has_updated_at
    repo              = TransactionRepository.new(fake_sales_engine)
    repo.transactions = []

    transaction = repo.create(new_transaction_input, fake_invoice_id)

    assert_equal Date.parse(Date.today.strftime), transaction.updated_at
  end

  def test_new_transation_added_to_repository
    repo              = TransactionRepository.new(fake_sales_engine)
    repo.transactions = []

    repo.create(new_transaction_input, fake_invoice_id)

    assert_equal 1, repo.transactions.size
  end

end
