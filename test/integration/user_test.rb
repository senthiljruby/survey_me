require 'test_helper'

class UserTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user)
    @user.password = @user.password_confirmation = 'user123'
    @user.save!
    @survey = surveys(:survey_one)
  end

  test 'list of surveys' do
    login_as_user
    visit root_path
    within('.masthead') do
      click_link 'Survey'
    end
    assert has_content?(surveys(:survey_one).name)
    assert has_content?(surveys(:survey_one).question_type)
    assert has_content?(surveys(:survey_one).user.screen_name)
    assert has_content?('Take a survey')
    assert has_no_content?('Edit')
    assert has_no_content?('Delete')
    assert has_no_content?('Results')
  end

  test 'take an survey' do
    login_as_user
    visit root_path
    within('.masthead') do
      click_link 'Survey'
    end
    click_link "take_survey_#{@survey.id}"
    fill_in "user_answers_#{questions(:question_one).id}", :with => "My First Survey Answer"
    click_button 'Save'
    find('#flash_notice:contains("Survey was successfully completed.")')
  end

  test 'validate presence for survey answer' do
    login_as_user
    visit root_path
    within('.masthead') do
      click_link 'Survey'
    end
    click_link "take_survey_#{@survey.id}"
    click_button 'Save'
    find('#flash_notice:contains("User answer can\'t be blank")')
  end

  test 'validate numerical for numeric survey answer' do
    login_as_user
    visit root_path
    within('.masthead') do
      click_link 'Survey'
    end
    click_link "take_survey_#{surveys(:survey_two).id}"
    fill_in "user_answers_#{questions(:question_two).id}", :with => "Sample"
    click_button 'Save'
    find('#flash_notice:contains("User answer is not a number")')
  end

  test 'validate date format for date survey answer' do
    login_as_user
    visit root_path
    within('.masthead') do
      click_link 'Survey'
    end
    click_link "take_survey_#{surveys(:survey_three).id}"
    fill_in "user_answers_#{questions(:question_three).id}", :with => "Sample"
    click_button 'Save'
    find('#flash_notice:contains("User answer is not a valid date")')
  end

  test 'access denied' do
    login_as_user
    visit new_survey_path
    find('#flash_notice:contains("You are not authorized to view this content, please login as Admin")')
  end

  def login_as_user
    visit root_path
    within('.container') do
       click_link 'Login'
    end
    fill_in 'user_screen_name', :with => @user.screen_name
    fill_in 'user_password', :with => 'user123'
    click_button 'Sign in'
  end
end