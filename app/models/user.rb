class User < ActiveRecord::Base
  attr_accessor :passWord_confirmation
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :grants, through: :roles

  validates_confirmation_of :passWord
  validates_uniqueness_of :user_id
  validates_uniqueness_of :userName

  def id_name
    "#{user_id}_#{userName}"
  end
end
