# == Schema Information
#
# Table name: educations
#
#  id                  :integer          not null, primary key
#  cv_tran_id          :integer
#  degree              :string           not null
#  specialty           :string
#  institution         :string           not null
#  year                :integer          not null
#  institution_address :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Education < ApplicationRecord
  belongs_to :cv_tran
end
