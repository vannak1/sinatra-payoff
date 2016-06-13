class AddAccountToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :account_id, :integer
  end
end
