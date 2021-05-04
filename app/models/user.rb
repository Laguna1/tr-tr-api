class User < ApplicationRecord
 # encrypt password
 has_secure_password
 has_many :trains

 validates :name, presence: true, uniqueness: true
 validates :password_digest, presence: true
end
