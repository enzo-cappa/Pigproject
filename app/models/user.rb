class User < AbstractUser
  has_many :deposits
  has_many :orders

  def actual_account_state
    deposits_sum = self.deposits.sum(:amount)
    orders_sum = 0
    self.orders.each do |o|
      orders_sum += o.line_items.sum(:total_price)
    end
    total = deposits_sum - orders_sum
    total
  end

  def buyed_amount
    orders_sum = 0
    self.orders.each do |o|
      orders_sum += o.line_items.sum(:total_price)
    end
    orders_sum
  end
end
