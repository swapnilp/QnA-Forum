class Rss < ActiveRecord::Base
  attr_accessible :user_id, :comment, :location
  
  #asscoiation
  belongs_to :user
  
  #validation
  validates :user_id, :presence => true
  validates :comment, :presence => true
  
  #callback
  before_validation :validate_user

  def validate_user
    errors.add(:user_id, "not valid") if User.find_by_id(self[:user_id]) == nil
  end
end
