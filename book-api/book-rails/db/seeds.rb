# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# <Model>.delete_all deletes all records in a specific table
# used to avoid duplicates when running seed multiple times
# Here it is not used, because command: rails db:reset is preferred

# ActiveRecord::Base.connection.reset_pk_sequence!("users") # resents id sequence


# rails db:reset
# - Drops the database.
# - Creates it again.
# - Runs all migrations.
# - Runs db:seed.

# ---------- Inserting users ----------

users = [
  {
    name: "John",
    surname: "Doe",
    email: "admin1n@example.com",
    username: "admin1",
    password: "#Intel1#",
    role: :admin
  },
  {
    name: "Jane",
    surname: "Smith",
    email: "admin2@example.com",
    username: "admin2",
    password: "#Intel1#",
    role: :admin
  },
  {
    name: "Mark",
    surname: "Johnson",
    email: "manager1@example.com",
    username: "manager1",
    password: "#Intel1#",
    role: :manager
  },
  {
    name: "Emily",
    surname: "Brown",
    email: "manager2@example.com",
    username: "manager2",
    password: "#Intel1#",
    role: :manager
  },
  {
    name: "Michael",
    surname: "Davis",
    email: "manager3@example.com",
    username: "manager3",
    password: "#Intel1#",
    role: :manager
  },
  {
    name: "Sarah",
    surname: "Wilson",
    email: "manager4@example.com",
    username: "manager4",
    password: "#Intel1#",
    role: :manager
  },
  {
    name: "David",
    surname: "Taylor",
    email: "manager5@example.com",
    username: "manager5",
    password: "#Intel1#",
    role: :manager
  }
]

User.create!(users)
# ---------- Inserting users ----------
# -------------------------------------
