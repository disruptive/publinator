class AddShowInNav < ActiveRecord::Migration
  def up
    add_column :publications, :hide_in_submenu, :boolean, :default => false
  end

  def down
    remove_column :publications, :hide_in_submenu
  end
end
