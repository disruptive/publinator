class ProductType < ActiveRecord::Base
  self.table_name = 'product_types'
  acts_as_publishable
  attr_accessible   :title, :body, :section
  has_many          :products

  def slug
    publication.slug
  end

  def collection_name
    "Products"
  end

  def menu_collection
    products.collect{ |product| product.publication }
  end

  def publications
    products.collect{ |product| product.publication }
  end
end
