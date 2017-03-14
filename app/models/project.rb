# == Schema Information
#
# Table name: projects
#
#  id            :integer          not null, primary key
#  experience_id :integer
#  name          :string           not null
#  description   :string(500)
#  link          :string
#  technologies  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Project < ApplicationRecord
end
