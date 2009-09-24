class Deposit < ActiveRecord::Base
  belongs_to :user

  def user_id=(userid)
    self.user = User.find(userid)
  end
end
