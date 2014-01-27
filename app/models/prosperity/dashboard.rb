module Prosperity
  class Dashboard < ActiveRecord::Base
    has_many :dashboard_graphs
    has_many :graphs, through: :dashboard_graphs

    validates_presence_of :title
  end
end
