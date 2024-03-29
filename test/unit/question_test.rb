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

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test 'presence validation' do
    question = Question.new
    assert !question.save
    assert question.errors[:content].include?("can't be blank")
  end
end
