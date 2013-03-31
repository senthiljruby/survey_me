require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @admin.password = @admin.password_confirmation = 'admin123'
    @admin.save!
  end

  test 'invalid login' do
    visit root_path
    within('.container') do
       click_link 'Login'
    end
    find('.form-signin-heading:contains("Login")')
    fill_in 'user_screen_name', :with => @admin.screen_name
    fill_in 'user_password', :with => 'admin234'
    click_button 'Sign in'
    find('#flash_alert:contains("Invalid Screen Name or password.")')
  end

  test 'valid login' do
    visit root_path
    within('.container') do
       click_link 'Login'
    end
    find('.form-signin-heading:contains("Login")')
    fill_in 'user_screen_name', :with => @admin.screen_name
    fill_in 'user_password', :with => 'admin123'
    click_button 'Sign in'
    find('#flash_notice:contains("Signed in successfully.")')
  end

  test 'logout' do
    visit root_path
    within('.container') do
       click_link 'Login'
    end
    find('.form-signin-heading:contains("Login")')
    fill_in 'user_screen_name', :with => @admin.screen_name
    fill_in 'user_password', :with => 'admin123'
    click_button 'Sign in'
    find('#flash_notice:contains("Signed in successfully.")')
    visit root_path
    within('.container') do
       click_link 'Logout'
    end
    find('#flash_notice:contains("Signed out successfully.")')

  end
end