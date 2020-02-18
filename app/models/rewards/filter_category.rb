class Rewards::FilterCategory < ApplicationRecord
  belongs_to :rewards_filter, foreign_key: "rewards_filter_id",
                              inverse_of: :filter_categories,
                              class_name: "Rewards::Filter"
  belongs_to :category
end
