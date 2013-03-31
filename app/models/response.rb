# == Schema Information
#
# Table name: responses
#
#  id          :integer          not null, primary key
#  question_id :integer
#  user_answer :string(255)
#  user_id     :integer
#  survey_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Response < ActiveRecord::Base
  attr_accessible :question_id, :user_answer, :user_id, :survey_id

  belongs_to :user
  belongs_to :survey
  belongs_to :question

  validates :user_answer, :presence => true
end
