class Rewards::FilterCategory < ApplicationRecord
  belongs_to :rewards_filter, foreign_key: "rewards_filter_id"
  belongs_to :category
end
