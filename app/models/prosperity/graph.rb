module Prosperity
  class Graph < ActiveRecord::Base
    has_many :graph_lines

    validates_presence_of :title, :period, :option
  end
end
