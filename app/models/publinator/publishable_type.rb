module Publinator
  class PublishableType < ActiveRecord::Base
    attr_accessible :name, :sluggable, :layout

    def self.matches?(request)
      logger.info request.path_parameters
      logger.info request.path_parameters[:publishable_type]
      pt = self.find_by_name(request.path_parameters[:publishable_type].singularize.capitalize)
      return pt.present?
    end
  end
end
