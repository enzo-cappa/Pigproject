class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  validate :product_has_enough_stock

  def self.from_cart_item(cart_item)
    li = self.new
    li.product = cart_item.product
    li.quantity = cart_item.quantity
    li.total_price = cart_item.price
    li
  end

  def after_save
    super
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
    errors.add(:product, 'stock should be positive or cero' ) if product.stock < quantity
  end

end
