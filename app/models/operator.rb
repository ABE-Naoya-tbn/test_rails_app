# frozen_string_literal: true

class Operator < ApplicationRecord
  VALID_PASSWORD_REGEX = %r{\A[a-z\d$%#&()~\^+\-*/_<>!?]+\z}i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, presence: true, length: { minimum: 1, maximum: 64 }
  validates :password, presence: true, length: { minimum: 8, maximum: 64 }, format: { with: VALID_PASSWORD_REGEX }
  validates :password_confirmation, presence: { if: -> { password.present? } }
  validates :email, presence: true, length: { minimum: 1, maximum: 100 }, format: { with: VALID_EMAIL_REGEX }
  has_secure_password
end
