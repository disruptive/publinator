module Publinator
  class SiteWorkflow < ActiveRecord::Base
    attr_accessible :publishable_type, :site_id, :workflow_id
  end
end
