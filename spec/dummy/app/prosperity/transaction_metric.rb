class TransactionMetric < Prosperity::Metric
  scope { Transaction }

  group_by :date

  aggregate { sum(:amount_in_cents) }
end
