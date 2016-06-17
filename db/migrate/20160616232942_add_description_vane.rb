class AddDescriptionVane < ActiveRecord::Migration
  def change
    add_column :vanes, :description, :string
  end
end
