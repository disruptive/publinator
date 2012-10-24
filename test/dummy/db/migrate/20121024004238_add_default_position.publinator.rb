# This migration comes from publinator (originally 20121024001040)
class AddDefaultPosition < ActiveRecord::Migration
  def up
    add_column :publinator_asset_items, :position, :integer
    add_column :publinator_publishable_types, :position, :integer
    add_column :articles, :position, :integer
  end

  def down
    remove_column :publinator_asset_items, :position
    remove_column :publinator_publishable_types, :position
    remove_column :articles, :position
  end
end
