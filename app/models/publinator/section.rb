# TODO Validate new sections - can't conflict with publishable_types
module Publinator
  class Section < ActiveRecord::Base
    attr_accessible :layout, :name, :parent_id, :site_id
    belongs_to :site
    has_many :publications

    def self.matches?(request)
      pt = self.find_by_name(request.path_parameters[:section].downcase)
      return pt.present?
    end

  end
end
