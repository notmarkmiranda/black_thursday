require_relative 'test_helper'
require_relative '../lib/item'
require 'bigdecimal'
require 'pry'

class ItemTest < Minitest::Test
  def setup
          @item = Item.new({
              :id          => 145685852,
              :name        => "Pencil",
              :description => "You can use it to write things",
              :unit_price  => BigDecimal.new(10.99,4),
              :created_at  => Time.new(2016,03,1,11,24,14, "+07:00"),
              :updated_at  => Time.new(2016,03,1,11,24,14, "+07:00"),
            })
  end

  def test_it_returns_the_integer_id_of_the_item
    assert_equal 145685852, @item.id
  end

  def test_it_returns_the_name_of_the_item
    assert_equal "Pencil", @item.name
  end

  def test_it_returns_the_description_of_the_item
    assert_equal "You can use it to write things", @item.description
  end

  def test_it_returns_the_price_of_the_item
    assert_equal BigDecimal.new(10.99,4), @item.unit_price
  end

  def test_it_returns_a_Time_instance_for_the_date_the_item_was_first_created
    assert_equal Time.new(2016,03,1,11,24,14, "+07:00"), @item.created_at
  end

  def test_it_returns_a_Time_instance_for_the_date_the_item_was_last_modified
    assert_equal Time.new(2016,03,1,11,24,14, "+07:00"), @item.updated_at
  end

  def test_it_returns_the_integer_merchant_id_of_the_item
    assert_equal 0, @item.merchant_id
  end

end
