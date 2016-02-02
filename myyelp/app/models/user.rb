class User < ActiveRecord::Base
  has_secure_password validations: false
  has_many :reviews
  
  validates_presence_of :full_name
  validates :password, presence: true, on: :create, length: {minimum: 5}
  validates :email, presence: true, uniqueness: true
end