module Publinator
  class ApplicationController < ActionController::Base
    layout :current_layout
    
    helper_method :current_site, :current_domain, :current_layout
    
    def current_site
      @current_site ||= current_domain.site
    end
    
    def current_domain
      @current_domain ||= DomainName.get_by_domain_name(request)
    end
    
    def current_layout
      @current_layout ||= current_site.layout
    end
  end
end
