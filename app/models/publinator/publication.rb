module Publinator
  class Publication < ActiveRecord::Base
    # has_paper_trail
    attr_accessible :custom_slug, :parent_id, :publication_state_id, :publishable_id, :publishable_type, :site_id, :slug
    belongs_to :publishable, :polymorphic => true
    belongs_to :site
    scope :published, where(:publication_state_id => 1)
    
    def self.get_by_slug(slug)
      p1 = self.published.where(:slug => slug)
      p p1.class
      return p1
    end
  end
end
