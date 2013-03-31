require 'test_helper'

class ResponseTest < ActiveSupport::TestCase
  setup do
    @admin = users(:admin)
    @user = users(:user)
  end

  test "the truth" do
    assert true
  end

  test 'presence validation' do
    response = Response.new
    assert !response.save
    assert response.errors[:user_answer].include?("can't be blank")
  end
end
