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
