class AddPublicationCollections < ActiveRecord::Migration
  def up
    add_column :publinator_publications, :collection_object, :string
    add_column :publinator_publications, :collection_scope, :string
  end

  def down
    remove_column :publinator_publications, :collection_object
    remove_column :publinator_publications, :collection_scope
  end
end
