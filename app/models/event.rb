class Event < ApplicationRecord
  has_many :milestones

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
end
