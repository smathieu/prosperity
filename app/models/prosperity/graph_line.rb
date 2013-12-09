module Prosperity
  class GraphLine < ActiveRecord::Base
    belongs_to :graph
    ATTR_ACCESSIBLE = [:option, :metric].freeze
  end
end
