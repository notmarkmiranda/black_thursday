require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test

  def test_can_return_all_merchants
    assert_equal 21, @m_repo.all.size
  end

  def test_can_find_merchant_by_id
    assert_equal "Shopin1901", @m_repo.find_by_id(12334105).name
  end

  def test_can_find_merchant_by_name
    assert_equal 12334105, @m_repo.find_by_name("shopin1901").id
  end

  def test_can_find_all_merchants_by_name
    result = ["Shopin1901", "TheLilPinkBowtique"]
    assert_equal result, @m_repo.find_all_by_name("pin").map {|m| m.name}
  end

  def test_it_inspects
    assert_equal "#<MerchantRepository 21 rows>", @m_repo.inspect
  end

end
