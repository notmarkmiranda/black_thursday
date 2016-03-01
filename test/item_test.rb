require_relative 'test_helper'
require_relative '../lib/item'
require 'bigdecimal'
require 'pry'

class ItemTest < Minitest::Test
  def setup
          @item = Item.new({
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal.new(10.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
      })
  end

  #still need to write a takedown method that will erase the item
  #that was appended to file in each test

  def test_it_returns_the_integer_id_of_the_item
    skip
    assert_equal sumnum, @item.id
  end

  def test_it_returns_the_name_of_the_item #passing
    assert_equal "Pencil", @item.name
  end

  def test_it_returns_the_description_of_the_item #passing
    assert_equal "You can use it to write things", @item.description
  end

  def test_it_returns_the_price_of_the_item #passing
    assert_equal BigDecimal.new(10.99,4), @item.unit_price
  end

  def test_it_returns_a_Time_instance_for_the_date_the_item_was_first_created
    skip
    #not sure how we'll test this one...
    assert_equal Time.now, @item.created_at
  end

  def test_it_returns_a_Time_instance_for_the_date_the_item_was_last_modified
    skip
    #need to modify the file to run this test..create a special file with a single,
    #modification and run the test on that?
    assert_equal somedate, @item.updated_at
  end

  def test_it_returns_the_integer_merchant_id_of_the_item
    skip
    assert_equal sumnum, @item.merchant_id
  end

end
