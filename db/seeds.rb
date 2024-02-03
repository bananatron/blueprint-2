# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).


ActiveRecord::Base.transaction do
  password = SecureRandom.hex(16)
  user = User.create!(
    name: 'Seed',
    email: 'seed@toadstool.tech',
    password: password,
    password_confirmation: password,
    super: true,
  )

  builder = Builders::Session.new(host: user)
  builder.build
  raise builder.errors.join("\n") if builder.errors.any?

end
