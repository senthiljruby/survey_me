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
    find("td:contains('#{@survey.name}')")
    # find("td:contains('#{@survey.question_type}')")
    # find("td:contains('#{@survey.user.screen_name}')")
    find("td:contains('Take a survey')")
    find("td:contains('Edit')")
    find("td:contains('Delete')")
  end
end