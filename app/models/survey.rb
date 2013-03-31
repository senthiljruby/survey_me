class Survey < ActiveRecord::Base
  attr_accessible :name, :questions_attributes, :question_type, :user_id
  belongs_to :user
  has_many :questions
  accepts_nested_attributes_for :questions, allow_destroy: true
  has_many :responses

  validates :name, :presence => true
  validates :question_type, :presence => true
  
  self.per_page = 10
end
