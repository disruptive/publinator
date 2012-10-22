class CreatePublinatorPages < ActiveRecord::Migration
  def change
    create_table :publinator_pages do |t|
      t.integer :site_id
      t.string  :title
      t.string  :subtitle
      t.string  :kicker
      t.string  :teaser
      t.string  :custom_slug
      t.text    :body
      t.integer :position

      t.timestamps
    end
  end
end
