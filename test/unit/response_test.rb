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

require 'test_helper'

class ResponseTest < ActiveSupport::TestCase
  setup do
    @admin = users(:admin)
    @user = users(:user)
    @survey = surveys(:survey_one)
    @numeric_survey = surveys(:survey_two)
  end

  test "the truth" do
    assert true
  end

  test 'presence validation' do
    response = @survey.responses.new
    assert !response.save
    assert response.errors[:user_answer].include?("can't be blank")
  end

  test 'numerically validation' do
    response = @numeric_survey.responses.new
    response.user_answer = "sample"
    assert !response.save
    response.errors[:user_answer].include?('is not a number')
  end

end
