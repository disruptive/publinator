class Article < ActiveRecord::Base
  self.table_name = "articles"
  acts_as_publishable
  attr_accessible :title, :body, :section

  def asset_types
    ["header"]
  end
end
