class CreateProductTypes < ActiveRecord::Migration
  def self.up
    create_table :product_types do |t|
      t.string      :title
      t.string      :teaser
      t.text        :body
      t.integer     :site_id
      t.integer :position

      # t.string      :author_name
      # t.text        :extra_body
      # t.string      :kicker

      t.timestamps
    end

    Publinator::PublishableType.new(:name => "ProductType", :sluggable => "true")
  end

  def self.down
    drop_table :product_types
  end
end
