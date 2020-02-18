require "set"

class Category < ApplicationRecord
  class CyclicCategoryException < StandardError; end

  belongs_to :parent_category, class_name: "Category", optional: true
  validate :validate_root_has_no_parent
  validates :name, uniqueness: true
  validates :plaid_id, uniqueness: true, presence: true

  ROOT_CATEGORY_NAME = "All purchases"

  def root?
    parent_category.nil?
  end

  def contains?(other_category)
    return true if other_category.id == id

    Category.where(parent_category: self).any? do |child_category|
      child_category.contains?(other_category)
    end
  end

  private

  def validate_root_has_no_parent
    if name == ROOT_CATEGORY_NAME && parent_category.present?
      errors.add(:name, "is '#{ROOT_CATEGORY_NAME}', but it has a parent category")
    elsif name != ROOT_CATEGORY_NAME && parent_category.nil?
      errors.add(:parent_category, "is not present")
    end
  end
end
