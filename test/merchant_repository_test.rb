require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchants,
              :fake_sales_engine,
              :fixture_path,
              :merchant_input

  def setup
    @fake_sales_engine = "fake sales engine"
    @fixture_path      = './data/fixtures/merchants.csv'
    @merchant_input    = {
      id:         1,
      name:       'Schroeder-Jerde',
      created_at: '2012-03-27 14:53:59 UTC',
      updated_at: '2013-03-27 14:53:59 UTC'
    }

    merchant1 = Merchant.new(merchant_input, nil)
    merchant2 = Merchant.new(merchant_input, nil)
    merchant3 = Merchant.new(merchant_input, nil)
    merchant4 = Merchant.new(merchant_input, nil)

    @merchants = [merchant1, merchant2, merchant3, merchant4]
  end

  def test_it_knows_its_parent
    repo = MerchantRepository.new(fake_sales_engine)

    assert fake_sales_engine, repo.sales_engine
  end

  def test_it_has_merchants
    repo = MerchantRepository.new(fake_sales_engine)

    assert [], repo.merchants
  end

  def test_it_loads_the_data
    repo = MerchantRepository.new(fake_sales_engine)

    repo.load_data(fixture_path)

    assert_equal 4, repo.merchants.size
    assert_equal "Schroeder-Jerde", repo.merchants.first.name
  end

  def test_it_passes_itself_to_merchants
    path = @fixture_path
    repo = MerchantRepository.new(fake_sales_engine)

    repo.load_data(path)

    assert_equal repo, repo.merchants.first.repository
  end

  def test_it_has_an_inspect
    repo           = MerchantRepository.new(fake_sales_engine)
    repo.merchants = merchants

    assert_equal "#<MerchantRepository 4 rows>", repo.inspect
  end

  def test_find_all_by_id
    repo           = MerchantRepository.new(fake_sales_engine)
    repo.merchants = merchants

    assert_equal 4, repo.find_all_by_id(merchant_input[:id]).size
    assert_equal merchant_input[:id], repo.find_all_by_id(merchant_input[:id]).first.id
  end

  def test_find_all_by_name
    repo           = MerchantRepository.new(fake_sales_engine)
    repo.merchants = merchants

    assert_equal 4, repo.find_all_by_name(merchant_input[:name]).size
    assert_equal merchant_input[:name], repo.find_all_by_name(merchant_input[:name]).first.name
  end

  def test_find_all_by_created_at
    repo           = MerchantRepository.new(fake_sales_engine)
    repo.merchants = merchants

    assert_equal 4, repo.find_all_by_created_at(Date.parse(merchant_input[:created_at])).size
    assert_equal Date.parse(merchant_input[:created_at]), repo.find_all_by_created_at(Date.parse(merchant_input[:created_at])).first.created_at
  end

  def test_find_all_by_updated_at
    repo           = MerchantRepository.new(fake_sales_engine)
    repo.merchants = merchants

    assert_equal 4, repo.find_all_by_updated_at(Date.parse(merchant_input[:updated_at])).size
    assert_equal Date.parse(merchant_input[:updated_at]), repo.find_all_by_updated_at(Date.parse(merchant_input[:updated_at])).first.updated_at
  end

  def test_find_by_id
    repo           = MerchantRepository.new(fake_sales_engine)
    repo.merchants = merchants

    assert_equal merchant_input[:id], repo.find_by_id(merchant_input[:id]).id
  end

  def test_find_by_name
    repo           = MerchantRepository.new(fake_sales_engine)
    repo.merchants = merchants

    assert_equal merchant_input[:name], repo.find_by_name(merchant_input[:name]).name
  end

  def test_find_by_created_at
    repo           = MerchantRepository.new(fake_sales_engine)
    repo.merchants = merchants

    assert_equal Date.parse(merchant_input[:created_at]), repo.find_by_created_at(Date.parse(merchant_input[:created_at])).created_at
  end

  def test_find_by_updated_at
    repo           = MerchantRepository.new(fake_sales_engine)
    repo.merchants = merchants

    assert_equal Date.parse(merchant_input[:updated_at]), repo.find_by_updated_at(Date.parse(merchant_input[:updated_at])).updated_at
  end

  def test_random_returns_a_random_instance
    repo           = MerchantRepository.new(fake_sales_engine)
    expected       = 10000.times.map { |num| num }
    repo.merchants = expected

    refute repo.random.eql?(repo.random)
    refute repo.random.eql?(repo.random)
  end

  def test_all_returns_all_merchants_in_repository
    repo           = MerchantRepository.new(fake_sales_engine)
    expected       = ['array with alot of merchants', 'like two']
    repo.merchants = expected

    assert_equal expected, repo.all
  end

  # Upstream
  def test_it_finds_items_by_merchant_id
    sales_engine = Minitest::Mock.new
    repo         = MerchantRepository.new(sales_engine)

    sales_engine.expect(:find_items_by_merchant_id, nil, [1])
    repo.find_items(1)

    sales_engine.verify
  end

  def test_it_finds_invoices_by_id
    sales_engine = Minitest::Mock.new
    repo         = MerchantRepository.new(sales_engine)

    sales_engine.expect(:find_invoices_by_merchant_id, nil, [merchant_input[:id]])
    repo.find_invoices_by_id(merchant_input[:id])

    sales_engine.verify
  end

end
