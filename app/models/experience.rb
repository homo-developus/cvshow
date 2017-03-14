# == Schema Information
#
# Table name: experiences
#
#  id              :integer          not null, primary key
#  cv_tran_id      :integer
#  started_at      :datetime         not null
#  finished_at     :datetime
#  position        :string           not null
#  company         :string           not null
#  company_site    :string
#  company_address :string
#  duties          :string           is an Array
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Experience < ApplicationRecord
  belongs_to :cv_tran
  has_many :projects, dependent: :destroy

end
