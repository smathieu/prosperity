module Prosperity
  class DashboardGraph < ActiveRecord::Base
    belongs_to :dashboard
    belongs_to :graph
  end
end
