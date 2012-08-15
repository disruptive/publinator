module Publinator
  class Site < ActiveRecord::Base
    attr_accessible :abbr, :description, :name, :parent_id, :state, :title, :default
    has_many :domain_names
    
    # ideas: add ability to use a custom layout
    def layout
      'publinator/site' #self.type.to_s
    end
    
    def parent
      return nil unless parent_id.present?
      Site.find(self.parent_id)
    end
    
    def publications(scope = 'published', sort = 'updated_at desc', publishable_type)
      if publishable_type.nil?
        pubs = Publication.send(scope).order(sort)
      else
        pubs = Publication.send(scope).where(:publishable_type => publishable_type).order(sort)
      end
      if parent
        pubs += parent.pubs
        # TODO: resort this collection
        return pubs
      end
    end
  end
end
