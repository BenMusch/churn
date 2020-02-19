class Rewards::Point < ApplicationRecord
  belongs_to :card
  belongs_to :rewards_filter, class_name: "Rewards::Filter"
  belongs_to :rewards_points_type, class_name: "Rewards::PointsType"
end
