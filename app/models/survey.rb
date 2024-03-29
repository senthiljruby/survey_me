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

class Survey < ActiveRecord::Base
  attr_accessible :name, :questions_attributes, :question_type, :user_id, :questions
  belongs_to :user
  has_many :questions
  has_many :responses

  accepts_nested_attributes_for :questions, allow_destroy: true

  validates :name, :presence => true
  validates :question_type, :presence => true
  validates :questions, :presence => true

  self.per_page = 10
end