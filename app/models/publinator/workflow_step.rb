module Publinator
  class WorkflowStep < ActiveRecord::Base
    attr_accessible :notify, :position, :publishable_type, :require, :role, :workflow_id
  end
end
