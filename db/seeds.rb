# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless Admin.any?
  admin = Admin.new(username: 'admin', email: 'admin@usermanagement.com', password: 'Password@007', password_confirmation: 'Password@007')
  if admin.save
    puts 'Admin created successfully'
    puts 'User Name : admin'
    puts 'Password  : Password@007'
  else
    puts 'Unable to seed admin user'
    puts admin.errors.full_messages.join(', ')
  end
end
