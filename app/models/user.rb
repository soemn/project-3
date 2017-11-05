class User < ApplicationRecord
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :password_digest,
            length: { in: 8..72 },
            on: :create

  has_secure_password

  def self.find_and_authenticate_user(params)
    User.find_by_email(params[:email]).try(:authenticate, params[:password_digest])
  end
end
