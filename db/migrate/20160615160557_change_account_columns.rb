class ChangeAccountColumns < ActiveRecord::Migration
  def change
    change_column :accounts, :date, :datetime
    change_column :accounts, :balance, :decimal
    change_column :accounts, :interest, :decimal
    change_column :accounts, :min_payment, :decimal
    change_column_null :accounts, :balance, false
    change_column_null :accounts, :interest, false
    change_column_null :accounts, :min_payment, false
  end
end
