require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @merchant_1 = Merchant.new({:id => 1, :name => "Turing School"})
    @merchant_2 = Merchant.new({:id => 2, :name => "Galvanize"})
    @mr = MerchantRepository.new([@merchant_1, @merchant_2])
  end

  def test_can_create_blank_merchant_repo
    mr2 = MerchantRepository.new
    assert_equal [], mr2.merchant
  end

  def test_can_accept_new_merchants
    refute @mr.merchant.empty?
  end

  def test_all_returns_all_known_instances
    assert_equal [@merchant_1, @merchant_2], @mr.all
  end

  def test_find_by_id_can_return_nil
    assert_equal nil, @mr.find_by_id(3)
  end

  def test_find_by_id_can_find_instance
    assert_equal @merchant_1, @mr.find_by_id(1)
  end

  def test_find_by_name_can_return_nil
    assert_equal nil, @mr.find_by_name("costco")
  end

  def test_find_by_name_can_find_instance
    assert_equal @merchant_1, @mr.find_by_name("Turing")
  end

  def test_find_all_by_name_can_return_blank
    assert_equal [], @mr.find_all_by_name("walmart")
  end

  def test_find_all_by_name_can_return_instance
    merchant_3 = Merchant.new({:id => 3, :name => "Galvanize Boulder"})
    mr2 = MerchantRepository.new([@merchant_1, @merchant_2, merchant_3])

    assert_equal [@merchant_2, merchant_3], mr2.find_all_by_name("Galvanize")
  end

end
