class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :name
      t.string :address
      t.string :userName
      t.string :passWord
      t.boolean :enabled

      t.timestamps
    end
  end
end
