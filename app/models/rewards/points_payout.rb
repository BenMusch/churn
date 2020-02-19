class Rewards::PointsPayout < ApplicationRecord
  belongs_to :rewards_points_type,
             foreign_key: :rewards_points_type_id,
             inverse_of: :rewards_points_payouts,
             class_name: "Rewards::PointsType"
  belongs_to :rewards_filter,
             foreign_key: :rewards_filter_id,
             inverse_of: :rewards_points_payouts,
             class_name: "Rewards::Filter"
end
