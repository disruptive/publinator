module Publinator
  class Page < ActiveRecord::Base
    self.table_name = 'publinator_pages'
    acts_as_publishable
    attr_accessible :body, :kicker, :subtitle, :teaser, :title, :section, :asset_items, :asset_item, :asset_file
    belongs_to :section, :class_name => "Publinator::Page"

    def asset_types
      ['header','pdf_document']
    end

    def name
      title
    end

    if ThinkingSphinx
      define_index do
        indexes title
        indexes body
        indexes subtitle
        has created_at, updated_at
      end
    end

  end
end
