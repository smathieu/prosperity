require "prosperity/engine"
require "prosperity/main_app_route_delegator"

module Prosperity
  mattr_accessor :parent_controller
  self.parent_controller = 'ActionController::Base'

  mattr_accessor :parent_layout
  self.parent_layout = 'prosperity/base'

  class << self
    def layout=(layout)
      self.parent_layout = layout
      if layout && layout !~ %r(^prosperity/)
        # inline application routes if using an app layout
        inline_main_app_routes!
      end
    end

    def inline_main_app_routes!
      ::Prosperity::ApplicationController.helper ::Prosperity::MainAppRouteDelegator
    end
  end
end
