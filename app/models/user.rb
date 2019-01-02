class User < ApplicationRecord
  validates :username, presence: true, length: {minimum:2, maximum:50}
  validates :f_name, presence: true, length: {minimum:2, maximum:50}
  validates :l_name, presence: true, length: {minimum:2, maximum:50}
  validates :password, presence: true, length: {minimum:2, maximum:50}
  has_secure_password
end
