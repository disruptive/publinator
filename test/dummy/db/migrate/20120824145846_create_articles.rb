class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string      :title
      t.text        :body
      
      #t.string      :teaser
      # t.string      :author_name
      # t.text        :extra_body
      # t.string      :kicker

      t.timestamps
    end
  end
  
  def self.down
    drop_table :articles
  end
end