module Prosperity
  class Graph < ActiveRecord::Base
    has_many :graph_lines, class_name: 'Prosperity::GraphLine'
    validates_presence_of :title, :period
    accepts_nested_attributes_for :graph_lines, reject_if: :not_filled?, allow_destroy: true

    ATTR_ACCESSIBLE = [:title, :period, :graph_lines, :graph_type].freeze

    attr_accessible *ATTR_ACCESSIBLE unless defined?(ActionController::StrongParameters)

    VALID_GRAPH_TYPES = %w(line area)
    validates :graph_type, inclusion: {in: VALID_GRAPH_TYPES}

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
