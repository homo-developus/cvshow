# == Schema Information
#
# Table name: cvs
#
#  id         :integer          not null, primary key
#  token      :string(6)
#  birthday   :datetime         not null
#  email      :string           not null
#  phone      :string
#  skype      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
