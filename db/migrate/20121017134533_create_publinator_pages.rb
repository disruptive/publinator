class CreatePublinatorPages < ActiveRecord::Migration
  def change
    create_table :publinator_pages do |t|
      t.string :title
      t.string :subtitle
      t.string :kicker
      t.string :teaser
      t.text :body
      t.integer :section_id

      t.timestamps
    end
  end
end
