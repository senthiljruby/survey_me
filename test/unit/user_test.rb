# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  full_name              :string(255)
#  admin                  :boolean          default(FALSE), not null
#  screen_name            :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

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
