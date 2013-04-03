require 'test_helper'

class AdminTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @admin.password = @admin.password_confirmation = 'admin123'
    @admin.save!
    @survey = surveys(:survey_one)
  end

  test 'list of surveys' do
    login_as_admin
    visit root_path
    within('.masthead') do
      click_link 'Survey'
    end
    assert has_content?(surveys(:survey_one).name)
    assert has_content?(surveys(:survey_one).question_type)
    assert has_content?(surveys(:survey_one).user.screen_name)
    assert has_content?('Edit')
    assert has_content?('Delete')
    assert has_content?('Results')
  end

  test 'new Essay Survey' do
    login_as_admin
    visit root_path
    within('.masthead') do
      click_link 'Survey'
    end
    click_link 'New Survey'
    select 'Essay', :from => 'question_type'
    click_button 'Select Survey'
    fill_in 'survey_name', :with => 'sample_survey'
    fill_in 'survey_questions_attributes_0_content', :with => 'Sample Essay Question'
    click_button 'Create Survey'
    find('#flash_notice:contains("Survey was successfully created.")')
  end

  test 'new Numeric Survey' do
    login_as_admin
    visit root_path
    within('.masthead') do
      click_link 'Survey'
    end
    click_link 'New Survey'
    select 'Essay', :from => 'question_type'
    click_button 'Select Survey'
    fill_in 'survey_name', :with => 'sample_survey'
    fill_in 'survey_questions_attributes_0_content', :with => 'Sample Numeric Question'
    click_button 'Create Survey'
    find('#flash_notice:contains("Survey was successfully created.")')
  end

  test 'new Date Survey' do
    login_as_admin
    visit root_path
    within('.masthead') do
      click_link 'Survey'
    end
    click_link 'New Survey'
    select 'Essay', :from => 'question_type'
    click_button 'Select Survey'
    fill_in 'survey_name', :with => 'sample_survey'
    fill_in 'survey_questions_attributes_0_content', :with => 'Sample Date Question'
    click_button 'Create Survey'
    find('#flash_notice:contains("Survey was successfully created.")')
  end

  test 'invalid survey for essay question creation' do
    login_as_admin
    visit root_path
    within('.masthead') do
      click_link 'Survey'
    end
    click_link 'New Survey'
    select 'Essay', :from => 'question_type'
    click_button 'Select Survey'
    click_button 'Create Survey'
    find('.alert:contains("Questions content can\'t be blank")')
    find('.alert:contains("Name can\'t be blank")')
  end

  test 'results' do
    login_as_admin
    visit root_path
    within('.masthead') do
      click_link 'Survey'
    end
    click_link "survey_results_#{@survey.id}"
    assert has_content?(responses(:one).user.screen_name)
    assert has_content?(responses(:one).question.content)
    assert has_content?(responses(:one).user_answer)
  end

  test 'destroy' do
    login_as_admin
    visit root_path
    within('.masthead') do
      click_link 'Survey'
    end
    click_link "delete_survey_#{@survey.id}"
    page.driver.browser.switch_to.alert.accept
  end

  test 'edit' do
    login_as_admin
    visit root_path
    within('.masthead') do
      click_link 'Survey'
    end
    click_link "edit_survey_#{@survey.id}"
    fill_in 'survey_name', :with => 'sample_survey_updated'
    fill_in 'survey_questions_attributes_0_content', :with => 'Sample Date Question updated'
    click_button 'Update Survey'
    find('#flash_notice:contains("Survey was successfully updated.")')
  end

  test 'invalid edit' do
    login_as_admin
    visit root_path
    within('.masthead') do
      click_link 'Survey'
    end
    click_link "edit_survey_#{@survey.id}"
    fill_in 'survey_name', :with => ''
    fill_in 'survey_questions_attributes_0_content', :with => ''
    click_button 'Update Survey'
    find('.alert:contains("Questions content can\'t be blank")')
    find('.alert:contains("Name can\'t be blank")')
  end

  def login_as_admin
    visit root_path
    within('.container') do
       click_link 'Login'
    end
    fill_in 'user_screen_name', :with => @admin.screen_name
    fill_in 'user_password', :with => 'admin123'
    click_button 'Sign in'
  end
end