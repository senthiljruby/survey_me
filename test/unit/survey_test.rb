require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  setup do
    @admin = users(:admin)
    @user = users(:user)
  end

  test "the truth" do
    assert true
  end

  test 'presence validation' do
    survey = Survey.new
    assert !survey.save
    assert survey.errors[:name].include?("can't be blank")
    assert survey.errors[:question_type].include?("can't be blank")
  end
end
