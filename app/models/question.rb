class Question < ActiveRecord::Base

 # WillPaginate.per_page = 10
  attr_accessible :question, :user_id
  #associations
  has_many :answers
  belongs_to :user

  #validations
  validates_associated :answers
  validates :user_id, :presence => true
  validates :question, :presence => true
  
  #callbacks
  before_validation :validate_user

  def validate_user
    errors.add(:user_id, "not valid") if User.find_by_id(self[:user_id]) == nil
  end
end
