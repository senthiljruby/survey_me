require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  setup do
    @admin = users(:admin)
    @user = users(:user)
  end

  test "the truth" do
    assert true
  end

  test 'presence validation' do
    answer = Answer.new
    assert !answer.save
    assert answer.errors[:content].include?("can't be blank")
  end
end
