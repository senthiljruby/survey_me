class Response < ActiveRecord::Base
  attr_accessible :question_id, :user_answer, :user_id, :survey_id

  belongs_to :user
  belongs_to :survey
  belongs_to :question

  validates :user_answer, :presence => true
end
