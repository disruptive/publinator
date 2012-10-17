class CreatePublinatorPublishables < ActiveRecord::Migration
  def change
    create_table :publinator_publishables do |t|
      t.integer :publication_id
      t.integer :site_id
      t.timestamps
    end
  end
end
