class Milestone < ApplicationRecord
  belongs_to :event

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :event, presence: true
end
