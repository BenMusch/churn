class ValueCalculator
  def self.value_of(transaction, card)
    points_total = card.rewards_points.map do |rewards_points|
      if rewards_points.rewards_filter.include?(transaction)
        rewards_points.points_per_dollar * transaction.amount
      else
        0
      end
    end.max

    # TODO: this assumes points are always cashback
    #       we should change this to return some sort of value object like
    #       PointsTotal which can then be given a value in a more complex way
    rewards_points_type = card.rewards_points.first.rewards_points_type
    rewards_points_type.rewards_points_payouts.first.dollars_per_point * points_total
  end
end
