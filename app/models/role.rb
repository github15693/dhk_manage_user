class Role < ActiveRecord::Base
  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles

  has_many :role_grants, dependent: :destroy
  has_many :grants, through: :role_grants


  def id_name
    "#{role_id}_#{role_name}"
  end
end
