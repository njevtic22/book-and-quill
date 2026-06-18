class User < ApplicationRecord
  enum :role,
       {
         admin: "admin",
         manager: "manager"
       }

  validates :name, :surname, :email, :username, :password, :role, presence: true
  validates :email, :username, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, inclusion: { in: roles.keys }
end
