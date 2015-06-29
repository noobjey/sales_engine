class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :repository

  def initialize(line, repository)

    @id                          = line[:id].to_i
    @invoice_id                  = line[:invoice_id].to_i
    @credit_card_number          = line[:credit_card_number]
    @credit_card_expiration_date = line[:credit_card_expiration_date]
    @result                      = line[:result]
    @created_at                  = Date.parse(line[:created_at])
    @updated_at                  = Date.parse(line[:updated_at])
    @repository                  = repository
  end

  def invoice
    repository.find_invoice_by_invoice_id(invoice_id)
  end
end
