require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @admin.password = @admin.password_confirmation = 'admin123'
    @admin.save!
    @survey = surveys(:survey_one)
  end

  test 'list of surveys' do
    visit root_path
    within('.container') do
       click_link 'Login'
    end
    fill_in 'user_screen_name', :with => @admin.screen_name
    fill_in 'user_password', :with => 'admin123'
    click_button 'Sign in'
    visit root_path
    within('.masthead') do
      click_link 'Survey'
    end
    find("td[0]:contains('#{@survey.name}')")
    find("td[0]:contains('#{@survey.question_type}')")
    find("td[0]:contains('#{@survey.user.screen_name}')")
    find("td[0]:contains('Take a survey')")
    find("td[0]:contains('Edit')")
    find("td[0]:contains('Delete')")
  end
end