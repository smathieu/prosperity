module Prosperity
  class DashboardGraph < ActiveRecord::Base
    belongs_to :dashboard
    belongs_to :graph

    validates :dashboard, uniqueness: {scope: :graph, message: "already contains this graph"}
  end
end
