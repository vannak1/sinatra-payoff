class CreateUserVanes < ActiveRecord::Migration
  def change
    create_table :user_vanes do |t|
      t.integer :user_id
      t.integer :vane_id
    end
  end
end
