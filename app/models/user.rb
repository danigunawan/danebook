class User < ActiveRecord::Base

  has_secure_password

  accepts_nested_attributes 

  validates :password, length: { in: 8..24 }, allow_nil: true
  validates :first_name, :last_name, :email, presence: true, length: { maximum: 36 }



  def generate_token
    begin
      self.auth_token = SecureRandom.urlsafe_base64
    end while User.exists?(auth_token: self.auth_token)
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end
end
