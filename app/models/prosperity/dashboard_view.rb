module Prosperity
  class DashboardView < ActiveRecord::Base
    belongs_to :dashboard
    belongs_to :view
  end
end
