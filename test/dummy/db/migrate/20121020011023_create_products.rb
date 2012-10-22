class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string      :title
      t.string      :teaser
      t.text        :body
      t.integer     :site_id
      t.integer     :product_type_id
      t.integer :position

      # t.string      :author_name
      # t.text        :extra_body
      # t.string      :kicker

      t.timestamps
    end

    Publinator::PublishableType.new(:name => "Product", :sluggable => "true")
  end

  def self.down
    drop_table :products
  end
end
