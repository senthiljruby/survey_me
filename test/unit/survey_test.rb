# == Schema Information
#
# Table name: surveys
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  user_id       :integer
#  question_type :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  setup do
    @admin = users(:admin)
    @user = users(:user)
  end

  test "the truth" do
    assert true
  end

  test 'presence validation' do
    survey = Survey.new
    assert !survey.save
    assert survey.errors[:name].include?("can't be blank")
    assert survey.errors[:questions].include?("can't be blank")
    assert survey.errors[:question_type].include?("can't be blank")
  end
end
