require 'faker'
namespace :db do
  task :populate2 => :environment do
    11.times do |n|
          nickname  = Faker::Lorem.characters(10)
          firstname = Faker::Name.first_name
          lastname = Faker::Name.last_name
          email = Faker::Internet.email
          password  = 'password'
          role = 'simple'
          Admin.create!(:nickname => nickname,
                       :email => email,
                       :firstname => firstname,
                       :lastname => lastname,
                       :password => password,
                       :password_confirmation => password,
                       :role => role)
    end
  end
end