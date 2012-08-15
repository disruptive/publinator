# This migration comes from publinator (originally 20120725202425)
class CreatePublinatorWorkflowSteps < ActiveRecord::Migration
  def change
    create_table :publinator_workflow_steps do |t|
      t.integer :workflow_id
      t.integer :position
      t.string :role
      t.boolean :notify
      t.boolean :require
      t.string :publishable_type

      t.timestamps
    end
  end
end
