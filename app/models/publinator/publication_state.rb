module Publinator
  class PublicationState < ActiveRecord::Base
    attr_accessible :name, :system
  end
end
