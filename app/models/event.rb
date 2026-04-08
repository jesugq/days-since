class Event < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :occurred_on, presence: true
  validates :slug, presence: true, uniqueness: true

  before_validation :generate_slug, if: -> { slug.blank? && name.present? }

  def days_since
    return nil unless occurred_on

    (Date.current - occurred_on).to_i
  end

  def to_param
    slug
  end

  private

  def generate_slug
    base = name.parameterize
    candidate = base
    counter = 2

    while Event.where(slug: candidate).where.not(id: id).exists?
      candidate = "#{base}-#{counter}"
      counter += 1
    end

    self.slug = candidate
  end
end
