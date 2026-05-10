class Event < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :occurred_on, presence: true
  validates :slug, presence: true, uniqueness: true
end
