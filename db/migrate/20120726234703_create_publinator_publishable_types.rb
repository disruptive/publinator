class CreatePublinatorPublishableTypes < ActiveRecord::Migration
  def change
    create_table :publinator_publishable_types do |t|
      t.string :name
      t.string :sluggable, :default => true
      t.timestamps
    end
  end
end
