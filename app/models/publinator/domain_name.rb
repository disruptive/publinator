module Publinator
  # Ideas:
  #   * after_create adds link in ~/.pow in development
  class DomainName < ActiveRecord::Base
    attr_accessible :default, :name, :shared, :site_id, :subdomain
    belongs_to :site
    
    def self.get_by_domain_name(request)
      if request.env['x-forwarded-for']
        origin = request.env['x-forwarded-for'].to_s
        domain_array = origin.split('.')
        domain_array_length = origin.length
        if domain_array.length == 2
          request_subdomain = ""
          request_domain = origin
        elsif domain_array.length > 3
          request_subdomain = domain_array[domain_array_length - 3]
          request_domain = "#{domain_array[domain_array_length - 2]}.#{domain_array[domain_array_length - 1]}"
        end
      else
        request_subdomain = request.subdomain
        request_domain = request.domain
      end
      if request_domain.present?
        if request_subdomain.blank? || request_subdomain == 'www'
          @domain = self.find(:first, :conditions => ["name = ? AND (subdomain is null or subdomain = '')", request_domain])
        elsif request_subdomain.present? && request_subdomain != 'www'
          @domain = self.find(:first, :conditions => ["name = ? AND subdomain = ?", request_domain, request_subdomain])
        else
          @domain = self.find(:first, :conditions => ["name = ? AND subdomain = 'www' AND anchor = ?", request_domain, true])
        end
      else
        @domain = Site.default.domain_names.detect { |d| d.default }
      end
      return @domain
    end
  end
end
