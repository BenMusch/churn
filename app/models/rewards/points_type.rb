class Rewards::PointsType < ApplicationRecord
  has_many :rewards_points, class_name: "Rewards::Points", dependent: :destroy
  has_many :rewards_points_payouts,
           class_name: "Rewards::PointsPayout",
           dependent: :destroy,
           foreign_key: :rewards_points_type_id,
           inverse_of: :rewards_points_type
end
