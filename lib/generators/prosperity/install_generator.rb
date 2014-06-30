module Prosperity
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "creates an initializer file at config/initializers/prosperity.rb"
      source_root File.expand_path('../../../..', __FILE__)

      def generate_initialization
        copy_file 'config/initializers/prosperity.rb', 'config/initializers/prosperity.rb'
      end
    end
  end
end
