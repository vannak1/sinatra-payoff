class CreateTransaction < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :amount

      t.timestamps
   end
 end
end
