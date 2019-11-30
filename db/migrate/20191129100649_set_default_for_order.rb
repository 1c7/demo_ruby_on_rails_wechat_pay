class SetDefaultForOrder < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :status, :integer, default: 0, null: false
  end
end
