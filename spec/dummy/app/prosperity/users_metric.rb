class UsersMetric < Prosperity::Metric
  scope { User }

  option('with_1') do |scope|
    scope.with_1
  end

  option('no_results') do |scope|
    scope.where("1 = 2")
  end
end
