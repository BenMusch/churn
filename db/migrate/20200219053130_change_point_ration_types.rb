class ChangePointRationTypes < ActiveRecord::Migration[6.0]
  def change
    change_column :rewards_points_payouts, :dollars_per_point, :decimal
    change_column :rewards_points, :points_per_dollar, :decimal
  end
end
