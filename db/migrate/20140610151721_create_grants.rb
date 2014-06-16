class CreateGrants < ActiveRecord::Migration
  def change
    create_table :grants do |t|
      t.string :grant_id
      t.string :grant_name

      t.timestamps
    end
  end
end
