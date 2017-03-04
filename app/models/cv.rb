class Cv < ApplicationRecord
  has_many :cv_trans, dependent: :destroy
  before_create :generate_token

  protected

  def generate_token
    self.token = loop do
      random_token = SecureRandom.hex(3)
      break random_token unless Cv.exists?(token: random_token)
    end
  end
end
