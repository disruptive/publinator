class CreatePublinatorPublishableTypes < ActiveRecord::Migration
  def change
    create_table :publinator_publishable_types do |t|
      t.string :name
      t.boolean :sluggable, :default => true
      t.boolean :layout, :default => false
      t.timestamps
    end
  end
end
