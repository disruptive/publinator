class CreatePublinatorPublishableTypes < ActiveRecord::Migration
  def change
    create_table :publinator_publishable_types do |t|
      t.string :name
      t.boolean :sluggable, :default => true
      t.boolean :layout, :default => false
      t.string  :use_layout
      t.timestamps
    end
  end
end
