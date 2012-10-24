class AddDefaultPosition < ActiveRecord::Migration
  def up
    add_column :publinator_asset_items, :position, :integer
    add_column :publinator_publishable_types, :position, :integer
  end

  def down
    remove_column :publinator_asset_items, :position
    remove_column :publinator_publishable_types, :position
  end
end
