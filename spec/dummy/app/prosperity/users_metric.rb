class UsersMetric < Prosperity::Metric
  scope { User }

  options('with_1') do |scope|
    scope.with_1
  end

  options('no_results') do |scope|
    scope.where("1 = 2")
  end
end
