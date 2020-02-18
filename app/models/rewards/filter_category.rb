class Rewards::FilterCategory < ApplicationRecord
  belongs_to :rewards_filter, foreign_key: "rewards_filter_id",
                              inverse_of: :filter_categories
  belongs_to :category
end
