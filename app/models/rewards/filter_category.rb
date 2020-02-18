class Rewards::FilterCategory < ApplicationRecord
  belongs_to :rewards_filter
  belongs_to :category
end
