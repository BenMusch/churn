class AddRewardsPointsTypeToRewardsPoints < ActiveRecord::Migration[6.0]
  def change
    add_reference :rewards_points, :rewards_points_type, null: false, foreign_key: true, default: 1
  end
end
