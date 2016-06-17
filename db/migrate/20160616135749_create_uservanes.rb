class CreateUserVanes < ActiveRecord::Migration
  def change
    create_table :user_vane do |t|
      t.integer :user_id
      t.integer :vane_id

      t.timestamps
    end
  end
end
