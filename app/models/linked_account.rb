class LinkedAccount < ApplicationRecord
  belongs_to :institution
  belongs_to :user
  validates_uniqueness_of :plaid_id

  def self.create_from_plaid_data!(plaid_data, institution, user)
    create!(
      user: user,
      plaid_id: plaid_data["id"],
      plaid_type: plaid_data["type"],
      plaid_subtype: plaid_data["subtype"],
      mask: plaid_data["mask"],
      name: plaid_data["name"],
      institution: institution
    )
  end
end
