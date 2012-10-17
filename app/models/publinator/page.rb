module Publinator
  class Page < Publishable
    self.table_name = 'publinator_pages'
    attr_accessible :body, :kicker, :section_id, :subtitle, :teaser, :title
    belongs_to :section, :class_name => "Publinator::Section"
  end
end
