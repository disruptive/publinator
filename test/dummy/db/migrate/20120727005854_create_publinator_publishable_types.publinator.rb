# This migration comes from publinator (originally 20120726234703)
class CreatePublinatorPublishableTypes < ActiveRecord::Migration
  def change
    create_table :publinator_publishable_types do |t|
      t.string :name
      t.boolean :sluggable, :default => true
      t.boolean :layout, :default => true
      t.timestamps
    end
  end
end
