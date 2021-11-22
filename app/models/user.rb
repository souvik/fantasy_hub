class User < ApplicationRecord
  has_secure_password

  has_many :teams

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false },
    format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
end
