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
  attr_accessible :content, :survey_id
  
  belongs_to :survey
  has_many :responses

  validates :content, :presence => true

  QUESTION_TYPE = ['Essay', 'Numeric', 'Date']
end
