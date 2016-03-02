require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def setup
    @merchant_1 = Merchant.new({:id => 1, :name => "Turing School"})
    @merchant_2 = Merchant.new({:id => 2, :name => "Galvanize"})
  end

  def test_it_can_return_ids
    assert_equal 1, @merchant_1.id
    assert_equal 2, @merchant_2.id
  end

  def test_it_can_return_names
    assert_equal "Turing School", @merchant_1.name
    assert_equal "Galvanize", @merchant_2.name
  end

  def test_it_can_append_csv_file
    skip
    contents = CSV.open "./data/merchants.csv", "a", headers:true, header_converters: :symbol
    m = Merchant.new({:id => 5, :name => "Turing School"})

    assert contents.find { |row| row[:id] == "5" && row[:name] == "Turing School" }

    # Remove line created stuff starts here:
    rw_data = File.read("./data/merchants.csv").split("\n")
    rw_data.pop
    File.write("./data/merchants.csv", rw.join("\n"))
  end

end
