class Deposit < ActiveRecord::Base
  belongs_to :user

  validates_numericality_of :amount

  def user_id=(userid)
    self.user = User.find(userid)
  end
end
