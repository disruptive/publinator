class Article < Publinator::Publishable
  self.table_name = "articles"
  attr_accessible :title, :body
end