class Card < ApplicationRecord
  belongs_to :institution
  has_many :rewards_points, dependent: :destroy, class_name: "Rewards::Point"
end
