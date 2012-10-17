Given /^there is a section named "(.*?)"$/ do |name|
  FactoryGirl.create(:section, name: name, site: Publinator::Site.first)
end

Given /^the "(.*?)" section has (a|an) "(.*?)" called "(.*?)"$/ do |arg1, aoran, arg2, arg3|
  FactoryGirl.create(arg2.to_sym,
    publication: Publinator::Publication.create(custom_slug: 'index'),
    section_id: Publinator::Section.find_by_name(arg1).id,
    body: "#{arg1.humanize} Section Index Page"
  )
end

When /^I am using "(.*?)"$/ do |hostname|
  host! hostname
  Capybara.app_host = "http://#{hostname}"
end

When /^I visit the home page$/ do
  visit("/")
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