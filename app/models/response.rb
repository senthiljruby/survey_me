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
  validates :user_answer, :numericality => {:only_integer => true}, :if => :should_confirm_only_numeric?
  validates_date :user_answer, :if => :should_confirm_only_date?

  self.per_page = 10

  def should_confirm_only_numeric?
    return true if self.survey.question_type == "Numeric"
  end

  def should_confirm_only_date?
    return true if self.survey.question_type == "Date"
  end
end