class Grant < ActiveRecord::Base
  has_many :role_grants, dependent: :destroy
  has_many :roles, through: :role_grants

  def name
    "#{grant_id}_#{grant_name}"
  end
end
