# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


users = [
  { first_name: "Bhushan", last_name: "Nagpure", phone: "7040499405", email: "bhushan@gmail.com", password: "Bhushan@123" },
  { first_name: "Harsh", last_name: "Jagtap", phone: "7043399405", email: "harsh8@gmail.com", password: "Harsh@123" },
  { first_name: "Sahil", last_name: "Bheke", phone: "7046699405", email: "sahil@gmail.com", password: "Sahil@123" },
  { first_name: "Krushnal", last_name: "Patil", phone: "7044599405", email: "keushnal@gmail.com", password: "Keushnal@123" }
]

users.each do |user_data|
  User.find_or_create_by!(email: user_data[:email]) do |user|
    user.first_name = user_data[:first_name]
    user.last_name = user_data[:last_name]
    user.phone = user_data[:phone]
    user.password = user_data[:password]
  end
end

# creator = User.find_by(email: "bhushan@gmail.com")

# Group.create!(
#   group_name: "Room",
#   creator: User.find_by(email: "bhushan@gmail.com"),
#   description: "This group is dedicated to room expenses"
# )

# user = User.find_or_create_by!(first_name: "Bhushan", last_name: "Nagpure", phone: "7040499405", email: "bhushan@gmail.com", password: "Bhushan@123")
