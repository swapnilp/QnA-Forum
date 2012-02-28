class Answer < ActiveRecord::Base
  attr_accessible :user_id, :answer, :question_id
  #associations
  belongs_to :question
  belongs_to :user
  has_many :answerratings
  
  #validations
  validates_associated :answerratings
  validates :question_id, :presence => true
  validates :user_id, :presence => true
  validates :answer, :presence => true
  #callbacks
  before_validation :validate_user_question
  
  def validate_user_question
    errors.add(:user_id, "not valid") if User.find_by_id(self[:user_id]) == nil
    errors.add(:question_id, "not valid") if Question.find_by_id(self[:question_id]) == nil
  end
end
