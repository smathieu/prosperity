module Prosperity
  class GraphLine < ActiveRecord::Base
    belongs_to :graph
    ATTR_ACCESSIBLE = [:option, :metric, :extractor].freeze

    validates_presence_of :option, :metric, :extractor
  end
end
