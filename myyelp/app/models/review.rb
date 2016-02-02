class Review < ActiveRecord::Base
  belongs_to :business
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  validates_presence_of :review, :rating
end