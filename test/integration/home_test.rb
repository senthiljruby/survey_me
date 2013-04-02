require 'test_helper'

class HomeTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @admin.password = @admin.password_confirmation = 'admin123'
    @admin.save!
    @user = users(:user)
    @user.password = @user.password_confirmation = 'user123'
    @user.save!
  end

  test 'Home page' do
    visit root_path
    find('h1:contains("Survey Me")')
    find('a:contains("Take a Survey")')
    find('.container:contains("Welcome")')
    find('.container:contains("Guest")')
    find('.container:contains("Register")')
    find('.container:contains("Login")')
  end

  test 'Home page with login as admin' do
    visit root_path
    within('.container') do
       click_link 'Login'
    end
    fill_in 'user_screen_name', :with => @admin.screen_name
    fill_in 'user_password', :with => 'admin123'
    click_button 'Sign in'
    visit root_path
    find('h1:contains("Survey Me")')
    find('a:contains("Take a Survey")')
    find('.container:contains("Welcome")')
    find('.container:contains("admin")')
    find('.container:contains("Logout")')
  end

  test 'Home page with login as user' do
    visit root_path
    within('.container') do
       click_link 'Login'
    end
    fill_in 'user_screen_name', :with => @user.screen_name
    fill_in 'user_password', :with => 'user123'
    click_button 'Sign in'
    visit root_path
    find('h1:contains("Survey Me")')
    find('a:contains("Take a Survey")')
    find('.container:contains("Welcome")')
    find('.container:contains("senthil")')
    find('.container:contains("Logout")')
  end
end