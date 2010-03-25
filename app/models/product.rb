class Product < ActiveRecord::Base
  has_many :orders, :through => :line_items, :dependent => :destroy
  has_many :line_items, :dependent => :destroy
  has_many :sell_prices, :dependent => :destroy
  has_many :buy_prices, :dependent => :destroy
  has_one :product_image, :dependent => :destroy

  validates_presence_of :title, :description
  validates_numericality_of :price
  validates_uniqueness_of :title
  validates_numericality_of :stock
  validate :stock_must_be_positive

  named_scope :for_sale, :conditions => ["stock > 0"], :order => :title
  named_scope :starting_with, lambda{|letter|{:conditions => ["title LIKE ?", "#{letter}%"]}}
  default_scope :order => 'title ASC'

  protected

  def stock_must_be_positive
    errors.add(:stock, 'should be positive or cero' ) if stock.nil? ||
      stock < 0
  end

  def image=(file)
    image = ProductImage.new(:uploaded_data => file)
    image.save
    self.product_image = image
  end

  def reduce_stock(amount)
    self.stock = self.stock - amount
  end

  def increase_stock(amount)
    self.stock = self.stock + amount
  end

end
