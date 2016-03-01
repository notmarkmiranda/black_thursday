require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_can_create_blank_merchant_repo
    mr = MerchantRepository.new

    assert_equal [], mr.repo
  end

  def test_can_accept_new_merchants
    merchant_1 = Merchant.new({:id => 5, :name => "Turing School"})
    merchant_2 = Merchant.new({:id => 6, :name => "Galvanize"})
    mr = MerchantRepository.new([merchant_1, merchant_2])

    refute mr.repo.empty?

  end

  def test_all_returns_all_known_instances
    merchant_1 = Merchant.new({:id => 1, :name => "Turing School"})
    merchant_2 = Merchant.new({:id => 2, :name => "Galvanize"})
    merchant_3 = Merchant.new({:id => 3, :name => "General Assembly"})
    merchant_4 = Merchant.new({:id => 4, :name => "Flatiron"})
    mr = MerchantRepository.new([merchant_1, merchant_2, merchant_3, merchant_4])

    assert_equal [{:id => 1, :name => "Turing School"}, {:id => 2, :name => "Galvanize"}, {:id => 3, :name => "General Assembly"}, {:id => 4, :name => "Flatiron"}], mr.all
  end

  def test_find_by_id_can_return_nil
    skip
    merchant_1 = Merchant.new({:id => 5, :name => "Turing School"})
    merchant_2 = Merchant.new({:id => 6, :name => "Galvanize"})
    mr = MerchantRepository.new([merchant_1, merchant_2])


  end

  def test_find_by_id_can_find_instance
    skip
  end

  def test_find_by_name_can_return_nil
    skip
  end

  def test_find_by_name_can_find_instance
    skip
  end

  def test_find_all_by_name_can_return_blank
    skip
  end

  def test_find_all_by_name_can_return_instance
    skip
  end

end
