require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_it_can_append_csv_file
    contents = CSV.open "./data/merchants.csv", "a+", headers:true, header_converters: :symbol
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert contents.find { |row| row[:id] == "5" && row[:name] == "Turing School" }
    #still need to remove?
  end

end
