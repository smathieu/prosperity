require 'prosperity'

#= Application-specific
#
# # You can specify a controller for Prosperity::ApplicationController to inherit from:
# Prosperity.parent_controller = 'Admin::ApplicationController' # default: '::ApplicationController'

Rails.application.config.to_prepare do
  # # Render prosperity inside a custom layout (default is prosperity own layout)
  # Prosperity.layout = 'admin'

  # # If you use a *custom parent controller*, make helpers available:
  # Prosperity::ApplicationController.module_eval do
  #   helper Prosperity::Engine.helpers
  # end
end
