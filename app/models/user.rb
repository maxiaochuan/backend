# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  email           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string           not null
#  phone           :string
#

class User < ApplicationRecord
  VALID_EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_secure_password

  before_save { email.downcase! }

  validates :name,  presence: true, length: { maximum: 50 }

  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEXP },
                    uniqueness: { case_sensitive: false }

  validates :phone, presence: true, length: { is: 11 }, numericality: true,
                    uniqueness: { case_sensitive: false }, if: :phone_exist

  validates :password, presence: true, length: { minimum: 6, maximun: 20 }, if: :new_record_and_password_presence

  def phone_exist
    phone.presence
  end

  def new_record_and_password_presence
    new_record? || password.presence
  end

  def jwt_payload
    {
      iss: 'mxcins@gmail.com',
      exp: 1.hours.from_now.to_i,
      iat: DateTime.now.to_i,
      user: {
        id: id,
        name: name,
        email: email,
        phone: phone,
      }
    }
  end

  def jwt_secret
    Rails.application.credentials.secret_key_base
  end

  def jwt_token
    JWT.encode jwt_payload, jwt_secret, 'HS256'
  end
end
