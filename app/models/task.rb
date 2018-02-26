class Task < ApplicationRecord
  belongs_to :subject
  serialize :users
end
