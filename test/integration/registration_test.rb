require 'test_helper'

class RegistrationTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @admin.password = @admin.password_confirmation = 'admin123'
    @admin.save!
  end

  test 'invalid registration' do
    visit root_path
    within('.container') do
       click_link 'Register'
    end
    click_button 'Sign up'
    find('#error_explanation:contains("Email can\'t be blank")')
    find('#error_explanation:contains("Password can\'t be blank")')
    find('#error_explanation:contains("Screen name can\'t be blank")')

    visit root_path
    within('.container') do
      click_link 'Register'
    end
    fill_in 'user_email', :with => "senthil.jruby@gmail.com"
    fill_in 'user_screen_name', :with => 'senthil'
    fill_in 'user_full_name', :with => 'Senthil Kumar Bhaskaran'
    fill_in 'user_password', :with => 'foo'
    fill_in 'user_password', :with => 'bar'
    click_button 'Sign up'
    find('#error_explanation:contains("Password doesn\'t match confirmation")')
    find('#error_explanation:contains("Password is too short (minimum is 6 characters)")')

    visit root_path
    within('.container') do
      click_link 'Register'
    end
    fill_in 'user_email', :with => "senthil.jruby@gmail.com"
    fill_in 'user_screen_name', :with => 'senthil'
    fill_in 'user_full_name', :with => 'Senthil Kumar Bhaskaran'
    fill_in 'user_password', :with => 'foobar'
    fill_in 'user_password', :with => 'foobar'
    click_button 'Sign up'
    find('#error_explanation:contains("Screen name has already been taken")')
  end

  test 'valid registration' do
    visit root_path
    within('.container') do
      click_link 'Register'
    end
    fill_in 'user_email', :with => "senthil.jruby1@gmail.com"
    fill_in 'user_screen_name', :with => 'senthil1'
    fill_in 'user_full_name', :with => 'Senthil Kumar Bhaskaran'
    fill_in 'user_password', :with => 'senthil'
    fill_in 'user_password_confirmation', :with => 'senthil'
    click_button 'Sign up'
    find('#flash_notice:contains("Welcome! You have signed up successfully.")')
  end
end