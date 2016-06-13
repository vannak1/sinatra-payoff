class CreateAccount < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.integer :balance
      t.integer :interest
      t.integer :min_payment
      t.string :date
    #change date to due
      t.timestamps
    end
  end
end
