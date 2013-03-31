require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  setup do
    @admin = users(:admin)
    @user = users(:user)
  end

  test "the truth" do
    assert true
  end

  test 'presence validation' do
    question = Question.new
    assert !question.save
    assert question.errors[:content].include?("can't be blank")
  end
end