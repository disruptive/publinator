class CreatePublinatorSites < ActiveRecord::Migration
  def change
    create_table :publinator_sites do |t|
      t.string :name
      t.string :title
      t.text :description
      t.integer :parent_id
      t.string :state
      t.string :abbr
      t.string :type
      t.boolean :default

      t.timestamps
    end
  end
end
