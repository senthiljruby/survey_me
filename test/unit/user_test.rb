require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @admin = users(:admin)
    @user = users(:user)
  end

  test 'presence validation' do
    user = User.new
    assert !user.save
    assert user.errors[:screen_name].include?("can't be blank")
    assert user.errors[:email].include?("can't be blank")
    assert user.errors[:password].include?("can't be blank")
  end

  test 'confirmation validation' do
    @user.password = 'senthil'
    @user.password_confirmation = 'kumar'
    assert !@user.save
    assert @user.errors[:password].include?("doesn't match confirmation")
  end

  test 'length validation' do
    @user.password = 'foo'
    @user.password_confirmation = 'foo'
    assert !@user.save
    assert @user.errors[:password].include?("is too short (minimum is 6 characters)")
  end

  test 'unique validation' do
    user = User.new(:screen_name => 'senthil', :email => 'senthil.jruby@gmail.com')
    assert !user.save
    assert user.errors[:email].include?('has already been taken')
  end
end