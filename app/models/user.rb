class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :karma
  
  #association
  has_many :questions
  has_many :answers
  has_many :answerratings
  
  #validation
  validates_associated :questions
  validates_associated :answers
  validates_associated :answerratings
  validate :name, :presence => true

end
