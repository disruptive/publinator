class CreatePublinatorPublicationStates < ActiveRecord::Migration
  def change
    create_table :publinator_publication_states do |t|
      t.string :name, :null => false
      t.boolean :system, :default => false
      
      t.timestamps
    end
    Publinator::PublicationState.create(:name => "new", :system => true)
    Publinator::PublicationState.create(:name => "published", :system => true)
  end
end
