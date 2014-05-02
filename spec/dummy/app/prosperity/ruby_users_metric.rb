class RubyUsersMetric < Prosperity::Metric
  value_at do |time, period, *|
    User.where("users.created_at < ?", time).count
  end
end
