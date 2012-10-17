Publinator::Site.destroy_all
Publinator::DomainName.destroy_all
Publinator::Section.destroy_all
Article.destroy_all

site = Publinator::Site.create!(:name => "dummy", :default => true, :abbr => 'application')
Publinator::DomainName.create!(:site_id => 1, :name => 'dummy.dev', :shared => true, :default => true)
Publinator::Site.create!(:name => "dummy2", :default => false)
Publinator::DomainName.create!(:site_id => 2, :name => 'dummy.dev', :shared => false, :default => true, :subdomain => "dummy2")

# Article.create(:site_id => 1, :slug => "alphabits", :title => "Alphabits are not a Complete Breakfast")

# publication_state
#
# string  :name
# boolean :system

# publishable_type
# 
# string  :name
Publinator::PublishableType.create!(:name => "Article")

section = Publinator::Section.create!(:name => "New Articles", :layout => false, :site_id => site.id)

p "creating first article...."
Article.create!(:section_id => section.id, :custom_slug => 'index', :title => "Latest of the Latest", :body => "This is some article text.", :site_id => site.id)
Article.create!(:section_id => section.id, :title => "The last one", :body => "The last one, indeed.", :site_id => site.id)

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
