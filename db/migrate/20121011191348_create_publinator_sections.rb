class CreatePublinatorSections < ActiveRecord::Migration
  def change
    create_table :publinator_sections do |t|
      t.string :name
      t.integer :parent_id
      t.boolean :layout

      t.timestamps
    end
  end
end
