class Event < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :occurred_on, presence: true
  validates :slug, uniqueness: true

  before_validation :assign_slug

  def days_since_occurred_on
    return nil if occurred_on.blank?

    days = (Date.current - occurred_on).to_i
    days > 0 ? days : nil
  end

  private

  def assign_slug
    return if slug.present?
    
    base = name.to_s.parameterize
    base = "empty-event" if base.blank?

    candidate = generate_unique_slug(base)

    self.slug = candidate
  end

  def generate_unique_slug(base)
    candidate = base
    suffix = 1

    while slug_taken?(candidate)
      candidate = "#{base}-#{suffix}"
      suffix += 1
    end

    candidate
  end

  def slug_taken?(candidate)
    scope = Event.where(slug: candidate)
    scope = scope.where.not(id: id) if persisted?
    scope.exists?
  end
end
