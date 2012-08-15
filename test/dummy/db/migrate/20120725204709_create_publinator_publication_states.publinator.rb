# This migration comes from publinator (originally 20120725202042)
class CreatePublinatorPublicationStates < ActiveRecord::Migration
  def change
    create_table :publinator_publication_states do |t|
      t.string :name

      t.timestamps
    end
  end
end
