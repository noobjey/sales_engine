class TransactionParser
  attr_reader :data_location

  def initialize(data_location)
    @data_location = data_location
  end

  def parse
    csv                                  = CSV.open(data_location, headers: true)
    id_position                          = 0
    invoice_position                     = 1
    credit_card_number_postion           = 2
    credit_card_expiration_date_position = 3
    result_position                      = 4
    created_at_position                  = 5
    updated_at_position                  = 6


    result = csv.map do |row|
      Transaction.new(row[id_position],
                      row[invoice_position],
                      row[credit_card_number_postion],
                      row[credit_card_expiration_date_position],
                      row[result_position],
                      row[created_at_position],
                      row[updated_at_position])
    end

    result
  end
end
