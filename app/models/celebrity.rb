class Celebrity < ApplicationRecord
  belongs_to :medium

  validates :name, presence: true
end
