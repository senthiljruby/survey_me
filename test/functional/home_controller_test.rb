require 'test_helper'

class SurveysControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @survey = surveys(:survey_one)
    @question = questions(:question_one)
    @answer = answers(:answer_one)
    @admin = users(:admin)
    @user = users(:user)
  end

  test "should get home index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:surveys)
  end
end