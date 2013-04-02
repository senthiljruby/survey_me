require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @admin.password = @admin.password_confirmation = 'admin123'
    @admin.save!
  end

  test 'list of surveys' do
  end
end