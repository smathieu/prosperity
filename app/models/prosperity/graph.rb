module Prosperity
  class Graph < ActiveRecord::Base
    has_many :graph_lines, class_name: 'Prosperity::GraphLine'
    validates_presence_of :title, :period
    accepts_nested_attributes_for :graph_lines, reject_if: :not_filled?

    ATTR_ACCESSIBLE = [:title, :period, :graph_lines].freeze

    attr_accessible *ATTR_ACCESSIBLE unless defined?(ActionController::StrongParameters)

    private
    def not_filled?(line)
      if line[:id]
        false
      else
        line[:option].blank? || line[:metric].blank?
      end
    end
  end
end
