class Product < ActiveRecord::Base
  has_many :orders, :through => :line_items, :dependent => :destroy
  has_many :line_items, :dependent => :destroy
  has_one :product_image, :dependent => :destroy

  validates_presence_of :title, :description
  validates_numericality_of :price
  validate :price_must_be_at_least_a_cent
  validates_uniqueness_of :title
#  validates_format_of :image_url,
#    :with => %r{\.(gif|jpg|png)$}i,
#    :message => 'must be a URL for GIF, JPG ' +
#    'or PNG image.'

  def self.find_products_for_sale
    find(:all, :order => "title" )
  end

  protected

  def price_must_be_at_least_a_cent
    errors.add(:price, 'should be at least 0.01' ) if price.nil? ||
      price < 0.01
  end

  def image=(file)
    image = ProductImage.new(:uploaded_data => file)
    image.save
    self.product_image = image
  end

  def self.per_page
    10
  end

end
