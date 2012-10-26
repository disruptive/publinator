module Publinator
  class Site < ActiveRecord::Base
    attr_accessible :abbr, :description, :name, :parent_id, :state, :title, :default
    has_many :domain_names, :class_name => "Publinator::DomainName"
    has_many :sections,     :class_name => "Publinator::Section"
    has_many :publications, :class_name => "Publinator::Publication"

    # get the layout for the site
    #
    # @todo add ability to use a custom layout
    def layout
      begin
        abbr
      rescue ActionView::MissingTemplate
        "publinator/site"
      end
    end

    def parent
      return nil unless parent_id.present?
      Site.find(self.parent_id)
    end

    def default_url
      dn = domain_names.where(:default => true).first
      url = "http://"
      url += "#{dn.subdomain}." unless dn.subdomain.blank?
      url += "#{dn.name}"
      url
    end

    def url(path)
      "#{default_url}#{path}"
    end

    def publications(scope = 'published', sort = 'updated_at desc', publishable_type)
      if publishable_type.nil?
        pubs = Publication.for_site(self.id).send(scope).order(sort)
      else
        pubs = Publication.for_site(self.id).send(scope).where(:publishable_type => publishable_type).order(sort)
      end
      if parent
        pubs += parent.pubs
        # TODO: resort this collection
        return pubs
      end
    end
  end
end
