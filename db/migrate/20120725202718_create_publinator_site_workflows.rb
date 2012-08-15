class CreatePublinatorSiteWorkflows < ActiveRecord::Migration
  def change
    create_table :publinator_site_workflows do |t|
      t.integer :site_id
      t.integer :workflow_id
      t.string :publishable_type

      t.timestamps
    end
  end
end
