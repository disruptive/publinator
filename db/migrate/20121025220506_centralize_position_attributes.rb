class CentralizePositionAttributes < ActiveRecord::Migration
  def up
    add_column :publinator_publications, :position, :integer
  end

  def down
    remove_column :publinator_publications, :position
  end
end
