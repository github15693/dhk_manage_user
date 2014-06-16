class CreateRoleGrants < ActiveRecord::Migration
  def change
    create_table :role_grants do |t|
      t.belongs_to :role
      t.belongs_to :grant
      t.timestamps
    end
  end
end
