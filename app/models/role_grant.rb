class RoleGrant < ActiveRecord::Base
  belongs_to :role
  belongs_to :grant

end
