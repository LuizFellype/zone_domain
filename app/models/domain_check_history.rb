class DomainCheckHistory < ApplicationRecord
  has_many :available_domains

  enum status: %i[in_progress completed failed]
  validate :check_pattern

  private

  def check_pattern
    other_chars = pattern.split('').uniq - %w[C V]
    errors.add(:pattern, 'should include only C AND V') if other_chars.present?
  end
end
