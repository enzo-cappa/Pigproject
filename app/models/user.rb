
class User < AbstractUser
  has_many :deposits
  has_many :orders

end
