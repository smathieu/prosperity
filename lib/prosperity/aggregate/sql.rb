module Prosperity
  class Aggregate::Sql < Aggregate::Base
    def initialize(sql)
      @sql = sql
    end

    def to_sql
      @sql
    end

    def apply(scope, group_by_sql: nil)
      # This is pretty hacky.. this assumes that the aggregate SQL can be
      # inserted into this query and provide a valid query. We also leave it to
      # the extractor to set this value if needed
      if group_by_sql
        s = scope.select("#{group_by_sql} AS bucket, #{to_sql}")
        s.inject({}) {|accum, el|
          attr = el.attributes.keys.select do |key|
            !%w(id bucket).include?(key)
          end.first
          accum[el["bucket"]] = el.attributes[attr].to_f
          accum
        }
      else
        s = scope.select(to_sql)

        # This isn't a group by, we should return a single value rather than a
        # scope
        if s.group_values.empty?
          raise "Unexpected size" unless s.to_a.size == 1
          record = s.first
          # Assumes that the select statement as a single value attribute
          # AR always add id, so get rid of that
          value_attr = record.attributes.keys.first { |a| a != "id" }
          record.attributes[value_attr]
        else
          s
        end
      end
    end
  end
end

