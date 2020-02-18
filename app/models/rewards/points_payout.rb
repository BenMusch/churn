class Rewards::PointsPayout < ApplicationRecord
  belongs_to :points_type
  belongs_to :category
end
