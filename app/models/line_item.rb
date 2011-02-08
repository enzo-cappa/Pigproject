class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  belongs_to :sell_price
 
  validate :product_has_enough_stock

  after_save :reduce_stock
  
  def self.from_cart_item(cart_item)
    li = self.new
    li.product = cart_item.product
    li.quantity = cart_item.quantity
    li.total_price = cart_item.price
    li.sell_price = li.product.active_sell_price
    li
  end

  def reduce_stock
    self.product.reduce_stock(self.quantity)
    self.product.save
  end

  def destroy
    self.product.increase_stock(self.quantity)
    self.product.save
    super
  end

  protected

  def product_has_enough_stock
    errors.add(:product, 'the product doesn\'t have enough stock' ) if product.stock < quantity
  end

end
