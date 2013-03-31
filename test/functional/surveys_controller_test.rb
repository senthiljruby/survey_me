require 'test_helper'

class SurveysControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @survey = surveys(:survey_one)
    @question = questions(:question_one)
    @first_answer = answers(:answer_one)
    @admin = users(:admin)
    @user = users(:user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:surveys)
  end

  test "should get new" do
    sign_in users(:admin)
    get :new
    assert_response :success
  end

  test "should create survey" do
    sign_in users(:admin)
    assert_difference('Survey.count') do
      post :create, survey: { name: @survey.name, question_type: @survey.question_type, user_id: @admin.id }
    end

    assert_redirected_to surveys_path
  end

  test "should show survey" do
    sign_in users(:admin)
    get :show, id: @survey
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:admin)
    get :edit, id: @survey
    assert_response :success
  end

  test "should update survey" do
    sign_in users(:admin)
    put :update, id: @survey, survey: { name: @survey.name }
    assert_redirected_to surveys_path
  end

  test "should destroy survey" do
    sign_in users(:admin)
    assert_difference('Survey.count', -1) do
      delete :destroy, id: @survey
    end
    assert_redirected_to surveys_path
  end

  test 'should store survey response' do
    sign_in users(:admin)
    post :update, id: @survey, question_ids: [@question.content],
                               user_answers: [@answer.content]
    assert_redirected_to surveys_path
  end

  test 'should display results' do
    sign_in users(:admin)
    get :results
    assert_response :success
    assert_not_nil assigns(:surveys)
  end
end
