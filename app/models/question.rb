# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  content    :text
#  survey_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ActiveRecord::Base
  attr_accessible :content, :survey_id, :answers_attributes
  
  belongs_to :survey
  has_many :responses
  has_many :answers

  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :content, :presence => true

  QUESTION_TYPE = ['Essay', 'Numeric', 'Date']
end
