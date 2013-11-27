module Prosperity
  class Dashboard < ActiveRecord::Base
    has_many :dashboad_views
    has_many :views, through: :dashboad_views

    validates_presence_of :title
  end
end
