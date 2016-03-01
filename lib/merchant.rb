require 'csv'

class Merchant
  @contents = CSV.open("./data/merchants.csv", "a+", headers:true, header_converters: :symbol)

  def initialize(hash)
    append_to_file(hash)
  end

  def append_to_file(hash)
    date = Date.today.strftime("%Y-%m-%d")
    hash[:created_at] = date
    hash[:updated_at] = date
    CSV.open("./data/merchants.csv", "a+", headers:true, header_converters: :symbol) do |row|
      row << hash.values
    end
  end


end
