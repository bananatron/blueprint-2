# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).


ActiveRecord::Base.transaction do

  WorldBuilder.call

  password = SecureRandom.hex(16)
  builder = Builders::User.new
  builder.build(
    name: 'Test',
    email: 'seed@toadstool.tech',
    password: password,
    super_user: true,
  )

  # TODO build rooms/worlds
end
