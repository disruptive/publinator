# This migration comes from publinator (originally 20120725202127)
class CreatePublinatorWorkflows < ActiveRecord::Migration
  def change
    create_table :publinator_workflows do |t|
      t.string :name

      t.timestamps
    end
  end
end
