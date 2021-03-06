class CreatePublinatorSections < ActiveRecord::Migration
  def change
    create_table :publinator_sections do |t|
      t.string :name
      t.integer :parent_id
      t.boolean :layout
      t.integer :site_id
      t.string :section_slug
      t.integer :position

      t.timestamps
    end
  end
end
