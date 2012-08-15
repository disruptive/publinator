# This migration comes from publinator (originally 20120725200404)
class CreatePublinatorDomainNames < ActiveRecord::Migration
  def change
    create_table :publinator_domain_names do |t|
      t.boolean :shared
      t.boolean :default
      t.string :name
      t.string :subdomain
      t.integer :site_id

      t.timestamps
    end
  end
end
