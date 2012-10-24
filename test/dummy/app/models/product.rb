class Product < ActiveRecord::Base
  self.table_name = 'products'
  acts_as_publishable
  attr_accessible   :title, :body, :section, :product_type, :product_type_id, :teaser
  belongs_to        :product_type
end
