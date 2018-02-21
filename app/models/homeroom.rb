class Homeroom < ApplicationRecord
  has_many :subjects
  has_many :users
end
