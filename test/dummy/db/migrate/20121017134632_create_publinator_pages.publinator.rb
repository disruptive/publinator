# This migration comes from publinator (originally 20121017134533)
class CreatePublinatorPages < ActiveRecord::Migration
  def change
    create_table :publinator_pages do |t|
      t.string :title
      t.string :subtitle
      t.string :kicker
      t.string :teaser
      t.text :body
      t.integer :section_id
      t.integer :position
      t.integer :site_id

      t.timestamps
    end
    Publinator::PublishableType.create(:name => "Page", :sluggable => "true")
  end
end
