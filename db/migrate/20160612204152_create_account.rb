class CreateAccount < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
  end
end
