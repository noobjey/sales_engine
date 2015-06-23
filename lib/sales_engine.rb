require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
# # require_relative 'customer_repository'
# # require_relative 'transaction_repository'

class SalesEngine
  attr_accessor :merchant_repository,
                :item_repository,
                # :customer_repository,
                :invoice_item_repository,
                :invoice_repository
  # :transaction_repository,

  attr_reader :filepath

  def initialize(filepath)
    @filepath = filepath
  end

  def startup
    @merchant_repository ||= MerchantRepository.new(self)
    @merchant_repository.load_data("#{filepath}/merchants.csv")
    @item_repository ||= ItemRepository.new(self)
    @item_repository.load_data("#{filepath}/items.csv")
    @invoice_repository ||= InvoiceRepository.new(self)
    @invoice_repository.load_data("#{@filepath}/invoices.csv")
    # @customer_repository ||= CustomerRepository.new(self)
    # @customer_repository.load_data("#{@filepath}/customers.csv")
    # @transaction_repository ||= TransactionRepository.new(self)
    # @transaction_repository.load_data("#{@filepath}/transactions.csv")
    @invoice_item_repository ||= InvoiceItemRepository.new(self)
    @invoice_item_repository.load_data("#{@filepath}/invoice_items.csv")
  end

  def find_items_by_merchant_id(id)
    item_repository.find_all_by_merchant_id(id)
  end

  def find_merchant_by_id(id)
    merchant_repository.find_by_id(id)
  end

  def find_invoice_items_by_item_id(id)
    invoice_item_repository.find_invoice_items_by_item_id(id)
  end
end
