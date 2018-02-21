class Subject < ApplicationRecord
  belongs_to :homeroom
  has_many :tasks
end
