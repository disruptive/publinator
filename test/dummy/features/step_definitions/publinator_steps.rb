Given /^there is a section named "(.*?)"$/ do |name|
  @section = FactoryGirl.create(:section, name: name, site: @site)
end

Given /^the "(.*?)" section has (a|an) "(.*?)" called "(.*?)"$/ do |arg1, aoran, arg2, arg3|
  @page = FactoryGirl.build(arg2.to_sym,
    section:  @section,
    body:     "#{arg1.humanize} Section #{arg3.capitalize} Page",
    site:     @site,
    title:    arg3)
  @page.save
end

Given /^"(.*?)" can publish "(.*?)"/ do |hostname, publishable_type_name|
  host! hostname
  Capybara.app_host = "http://#{hostname}"
  FactoryGirl.create(:publishable_type, name: publishable_type_name.singularize.capitalize)
end

When /^I am using "(.*?)"$/ do |hostname|
  host! hostname
  Capybara.app_host = "http://#{hostname}"
end

When /^I visit the home page$/ do
  visit("/")
end

When /^I visit the manage page$/ do
  visit("/manage/")
end

When /^I follow "(.*?)"$/ do |link_name|
  click_link(link_name)
end


When /^I visit "(.*?)"$/ do |path|
  visit(path)
end

Then /^I should see "(.*?)"$/ do |arg1|
  page.should have_content(arg1)
end

Then /show me the page/ do
  save_and_open_page
end
