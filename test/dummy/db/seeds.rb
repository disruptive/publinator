Publinator::Site.create(:name => "dummy", :default => true)
Publinator::DomainName.create(:site_id => 1, :name => 'dummy.dev', :shared => true, :default => true)
Publinator::Site.create(:name => "dummy2", :default => false)
Publinator::DomainName.create(:site_id => 2, :name => 'dummy.dev', :shared => false, :default => true, :subdomain => "dummy2")

# Article.create(:site_id => 1, :slug => "alphabits", :title => "Alphabits are not a Complete Breakfast")

# publication_state
#
# string  :name
# boolean :system

# publishable_type
# 
# string  :name
@article = Publinator::PublishableType.create(:name => "Article")

# workflows
#
# string  :name 
# Workflow.create
#@workflow = Workflow.create(:name => "")

# workflow_steps
#
# integer :workflow_id
# integer :position
# string  :role
# boolean :notify
# boolean :require
# string  :publishable_type
# WorkflowStep.create

# site_workflows
#
# integer :site_id
# integer :workflow_id
# string  :publishable_type
# SiteWorkflow.create(:site_id => , :workflow_id => , :publishable_id => )
