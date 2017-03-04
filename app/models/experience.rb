class Experience < ApplicationRecord
  belongs_to :cv_tran
  has_many :projects, dependent: :destroy

end
