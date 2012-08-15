class CreatePublinatorWorkflowSteps < ActiveRecord::Migration
  def change
    create_table :publinator_workflow_steps do |t|
      t.integer :workflow_id
      t.integer :position
      t.string :role
      t.boolean :notify
      t.boolean :require

      t.timestamps
    end
  end
end
