module Prosperity
  class Graph < ActiveRecord::Base
    has_many :graph_lines
  end
end
