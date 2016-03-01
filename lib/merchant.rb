require 'csv'

class Merchant
  attr_reader :id, :name
  @contents = CSV.open("./data/merchants.csv", "a+", headers:true, header_converters: :symbol)

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    # append_to_file(hash)
  end

  # def append_to_file(hash)
  #   date = Date.today.strftime("%Y-%m-%d")
  #   hash[:created_at] = date
  #   hash[:updated_at] = date
  #
  #   CSV.open("./data/merchants.csv", "a+", headers:true, header_converters: :symbol) do |row|
  #     row << hash.values
  #   end
  #   File.read("./data/merchants.csv")
  # end


end
