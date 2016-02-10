class Category < ActiveRecord::Base
  has_many :businesses, -> { order('created_at DESC')}
  validates_presence_of :name

  def recent_businesses
    return [] if id.blank?
    businesses.first(3)
  end
end