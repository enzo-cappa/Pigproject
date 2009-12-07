class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  def self.from_cart_item(cart_item)
    li = self.new
    li.product = cart_item.product
    li.quantity = cart_item.quantity
    li.total_price = cart_item.price
    li.product.reduce_stock (li.quantity)
    li.product.save
    li
  end

  def destroy
    self.product.increase_stock (self.quantity)
    self.product.save
    super
  end

end
