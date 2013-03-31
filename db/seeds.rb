# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
survey_admin = User.create(screen_name: 'admin', full_name: 'Administrator',  email: 'admin@test.com',
                            password: 'admin123', password_confirmation: 'admin123', admin: true)

survey_taker = User.create(screen_name: 'taker', full_name: 'Survey Taker',  email: 'taker@test.com',
                           password: 'taker123', password_confirmation: 'taker123')
