class Order < ActiveRecord::Base
  has_many :products, :through => :line_items
  has_many :line_items, :dependent => :destroy
  belongs_to :user

  validates_presence_of :user

  def add_line_items_from_cart(cart)
    cart.items.each do |item|
      li = LineItem.from_cart_item(item)
      line_items << li
    end
  end

  def total_amount
    amount = 0

    line_items.each do |l|
      amount = l.quantity * l.product.price
    end

    amount
  end
end
