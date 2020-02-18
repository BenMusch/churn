class Rewards::Point < ApplicationRecord
  belongs_to :card
  belongs_to :rewards_filter
end
