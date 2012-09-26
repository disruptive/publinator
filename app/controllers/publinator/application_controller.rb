module Publinator
  class ApplicationController < ActionController::Base
    layout :current_layout
    
    helper_method :current_site, :current_domain, :current_layout, :current_site_name
    
    def current_site_name
      return "Publinator" if current_site.nil?
      @current_site_name ||= current_site.name
    end
    
    def current_site
      return nil if current_domain.nil?
      @current_site ||= current_domain.site
    end
    
    def current_domain
      @current_domain ||= DomainName.get_by_domain_name(request)
    end
    
    def current_layout
      if current_site.nil?
        "publinator/publinator"
      else
        @current_layout ||= current_site.layout
      end
    end
  end
end
