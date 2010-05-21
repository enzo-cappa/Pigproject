class Price < ActiveRecord::Base
  belongs_to :product
  validate :must_be_at_least_a_cent
  validates_numericality_of :value

  default_scope :order => 'created_at DESC'

  def must_be_at_least_a_cent
     errors.add(:value, 'should be at least 0.01' ) if value.nil? || value < 0.01
  end
end
