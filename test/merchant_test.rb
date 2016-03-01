require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_it_can_create_an_instance_of_new_merchant
    newmerch = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal 5, newmerch.id
    assert_equal "Turing School", newmerch.name
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
