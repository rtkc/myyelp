class Category < ActiveRecord::Base
  has_many :businesses, -> { order('created_at DESC')}
  validates_presence_of :name

  def recent_businesses
    return [] if self.id.blank?
    self.businesses.first(3)
  end
end