class AddInbondToCalls < ActiveRecord::Migration[5.1]
  def change
    add_column :calls, :inbond, :boolean, null: false, default: true
  end
end
