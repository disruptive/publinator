# This migration comes from publinator (originally 20121023224457)
class AddShowInNav < ActiveRecord::Migration
  def up
    add_column :publinator_publications, :hide_in_submenu, :boolean, :default => false
  end

  def down
    remove_column :publinator_publications, :hide_in_submenu
  end
end
