class User < ActiveRecord::Base
  scope :with_1, -> { where("#{table_name}.name LIKE '%1%'") }
end
