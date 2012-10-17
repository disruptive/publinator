require 'spec_helper'
describe Publinator::Page do
  describe "#create" do
    it "has a valid factory" do
      FactoryGirl.create(:page).should be_valid
    end
    it "can include a section" do
      site    = FactoryGirl.create(:site)
      section = FactoryGirl.create(:section, site: site)
      page100 = Publinator::Page.new(title: "Title of Page 100", body: "Body of Page 100")
      page100.publication = Publinator::Publication.new(site: site, section: section, :custom_slug => 'index', :slug => 'index')
      page100.save.should == true
    end
    it "can create multiple pages in multiple sections" do
      site      = FactoryGirl.create(:site)
      section1  = FactoryGirl.create(:section, site: site)
      section2  = FactoryGirl.create(:section, site: site, name: 'Section Two')
      page100   = Publinator::Page.new(title: "Title of Page 100", body: "Body of Page 100")
      page101   = Publinator::Page.new(title: "Title of Page 101", body: "Body of Page 101")
      page200   = Publinator::Page.new(title: "Title of Page 200", body: "Body of Page 200")
      page201   = Publinator::Page.new(title: "Title of Page 201", body: "Body of Page 201")
      page100.publication = Publinator::Publication.new(site: site, section: section1, :custom_slug => 'index', :slug => 'index')
      page101.publication = Publinator::Publication.new(site: site, section: section1)
      page200.publication = Publinator::Publication.new(site: site, section: section2, :custom_slug => 'index', :slug => 'index')
      page201.publication = Publinator::Publication.new(site: site, section: section2)
      page100.save.should == true
      page101.save.should == true
      page200.save.should == true
      page201.save.should == true
    end
  end
end