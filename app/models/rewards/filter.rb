class Rewards::Filter < ApplicationRecord
  has_many :filter_categories, dependent: :destroy,
                               class_name: "Rewards::FilterCategory",
                               foreign_key: :rewards_filter_id,
                               inverse_of: :rewards_filter
  has_many :categories, through: :filter_categories
  has_many :rewards_points_payouts, dependent: :destroy,
                                    class_name: "Rewards::PointsPayout",
                                    foreign_key: :rewards_filter_id,
                                    inverse_of: :rewards_filter
  validate :validate_vendor_filter_regex

  def include?(transaction)
    vendor_filter_regex.match?(transaction.name) &&
      categories.any? { |category| category.contains?(transaction.category) }
  end

  private

  def vendor_filter_regex
    @vendor_filter_regex ||= Regexp.compile(vendor_filter)
  end

  def validate_vendor_filter_regex
    Regexp.compile(vendor_filter)
  rescue RegexpError
    errors.add(:vendor_filter, "is not a valid regex")
  end
end
