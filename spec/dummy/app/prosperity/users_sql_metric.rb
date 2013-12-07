class UsersSqlMetric < Prosperity::Metric
  sql "SELECT * from users"
end

