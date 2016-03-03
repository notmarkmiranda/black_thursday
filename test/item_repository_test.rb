require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require 'pry'


class ItemRepositoryTest < Minitest::Test

  def setup

    @pencil = Item.new({
        :id          => 145685852,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal.new(21.99,4),
        :created_at  => Time.new(2016,03,1,11,24,14, "+07:00"),
        :updated_at  => Time.new(2016,03,1,11,24,14, "+07:00"),
        :merchant_id => 20
      })

    @paper = Item.new({
        :id          => 145685851,
        :name        => "Paper",
        :description => "You can use it to write things on",
        :unit_price  => BigDecimal.new(21.99,4),
        :created_at  => Time.new(2016,03,1,11,24,14, "+08:00"),
        :updated_at  => Time.new(2016,03,1,11,24,14, "+08:00"),
        :merchant_id => 10
      })

    @eraser = Item.new({
        :id          => 145685850,
        :name        => "Eraser",
        :description => "You can use it to erase",
        :unit_price  => BigDecimal.new(41.99,4),
        :created_at  => Time.new(2016,03,1,11,24,14, "+09:00"),
        :updated_at  => Time.new(2016,03,1,11,24,14, "+09:00"),
        :merchant_id => 20
      })

      @repo = ItemRepository.new([@pencil, @paper, @eraser])
      @repo2 = ItemRepository.new

  end

  def test_it_returns_an_array_of_all_known_item_instances
    assert_equal [@pencil, @paper, @eraser], @repo.all
    assert_equal [], @repo2.all
  end

  def test_it_returns_an_instance_of_item_with_a_matching_id
    assert_equal @pencil, @repo.find_by_id(145685852)
    assert_equal nil, @repo.find_by_id(9283749284)
  end

  def test_it_returns_an_item_having_done_a_case_insensitive_search
    assert_equal @paper, @repo.find_by_name("Paper")
    assert_equal @paper, @repo.find_by_name("PAPER")
    assert_equal @paper, @repo.find_by_name("PAPE")
    assert_equal nil, @repo.find_by_name("hello")
  end

  def test_it_returns_items_where_the_supplied_string_appears_in_the_description
    assert_equal [@pencil, @paper, @eraser],  @repo.find_all_with_description("You can use it")
    assert_equal [@pencil, @paper, @eraser],  @repo.find_all_with_description("YOU CAN USE IT")
    assert_equal [@eraser], @repo.find_all_with_description("erase")
    assert_equal [], @repo.find_all_with_description("hello")
  end

  def test_it_returns_items_matching_the_given_price
    assert_equal [@pencil, @paper], @repo.find_all_by_price(BigDecimal.new(21.99,4))
    assert_equal [], @repo.find_all_by_price(BigDecimal.new(11.99,4))
  end

  def test_it_returns_items_within_the_given_price_range
    too_low = BigDecimal.new(10.99,4)
    low = BigDecimal.new(20.99,4)
    high = BigDecimal.new(50.99,4)
    range = (low..high)
    range2 = (too_low..low)
    assert_equal [@pencil, @paper, @eraser],  @repo.find_all_by_price_in_range(range)
    assert_equal [], @repo.find_all_by_price_in_range(range2)
  end

  def test_it_returns_items_matching_the_given_merchant_id
    assert_equal [@pencil, @eraser], @repo.find_all_by_merchant_id(20)
    assert_equal [], @repo.find_all_by_merchant_id(30)
  end

  def test_can_find_size_of_repository
    assert_equal 3, @repo.find_size
  end
end
