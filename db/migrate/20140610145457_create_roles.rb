class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :role_id
      t.string :role_name
      t.boolean :enabled

      t.timestamps
    end
  end
end
