# == Schema Information
#
# Table name: cv_trans
#
#  id               :integer          not null, primary key
#  cv_id            :integer
#  tran_lang        :enum             not null
#  full_name        :string           not null
#  marital_status   :string
#  address          :string
#  summary          :string(500)
#  personal_skills  :string
#  technical_skills :json
#  qualification    :string(100)      is an Array
#  links            :json
#  languages        :json
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class CvTran < ApplicationRecord
  belongs_to :cv
  has_many :educations, dependent: :destroy
  has_many :experiences, dependent: :destroy

  enum tran_lang: {
      en: 'en',
      ru: 'ru',
      ua: 'ua'
  }
end
