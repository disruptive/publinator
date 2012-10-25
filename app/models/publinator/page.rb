module Publinator
  class Page < ActiveRecord::Base
    self.table_name = 'publinator_pages'
    acts_as_publishable
    attr_accessible :body, :kicker, :subtitle, :teaser, :title, :section, :asset_items, :asset_item, :asset_file
    belongs_to :section, :class_name => "Publinator::Page"

    def asset_types
      ['header']
    end

    def name
      title
    end

  end
end
