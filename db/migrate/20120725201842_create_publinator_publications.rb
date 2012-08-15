class CreatePublinatorPublications < ActiveRecord::Migration
  def change
    create_table :publinator_publications do |t|
      t.integer :site_id
      t.integer :publication_state_id
      t.integer :parent_id
      t.string :custom_slug
      t.string :slug
      t.string :publishable_type
      t.integer :publishable_id

      t.timestamps
    end
  end
end
