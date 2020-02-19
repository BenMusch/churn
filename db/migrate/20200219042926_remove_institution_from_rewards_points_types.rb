class RemoveInstitutionFromRewardsPointsTypes < ActiveRecord::Migration[6.0]
  def change
    remove_column :rewards_points_types, :institution_id, :integer
  end
end
