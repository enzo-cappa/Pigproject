class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

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
