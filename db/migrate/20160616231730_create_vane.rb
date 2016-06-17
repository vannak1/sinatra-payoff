class CreateVane < ActiveRecord::Migration
  def change
    create_table :vanes do |t|
      t.string :name
      t.decimal :amount

      t.timestamps null:false
    end
  end
end
