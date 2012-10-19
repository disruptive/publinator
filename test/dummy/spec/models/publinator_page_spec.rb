require 'spec_helper'
describe Publinator::Page do
  describe "#create" do
    it "has a valid factory" do
      FactoryGirl.create(:page).should be_valid
    end

    it "can include a section" do
      site    = FactoryGirl.create(:site)
      section = FactoryGirl.create(:section, site: site)
      page100 = Publinator::Page.new(title: "Title of Page 100", body: "Body of Page 100", site: site, section: section, :default => true)
      page100.save.should be_true
      page100.publication.section_id.should == section.id
      page100.publication.site_id.should == site.id
      page100.publication.slug.should == 'index'
    end

    it "generates the slug first-page-name for a page titled 'First Page Name'" do
      site    = FactoryGirl.create(:site)
      page = Publinator::Page.new(title: "First Page Name", body: "Body of Page 100", site: site)
      page.save.should == true
      page.publication.slug.should == 'first_page_name'
    end

    it "can create multiple pages in multiple sections" do
      site      = FactoryGirl.create(:site)
      section1  = FactoryGirl.create(:section, site: site, name: 'Section One')
      section2  = FactoryGirl.create(:section, site: site, name: 'Section Two')

      page100   = Publinator::Page.new(title: "Title of Page 100", body: "Body of Page 100", site: site, section: section1, default: true)
      page101   = Publinator::Page.new(title: "Title of Page 101", body: "Body of Page 101", site: site, section: section1)
      page200   = Publinator::Page.new(title: "Title of Page 200", body: "Body of Page 200", site: site, section: section2, default: true)
      page201   = Publinator::Page.new(title: "Title of Page 201", body: "Body of Page 201", site: site, section: section2)

      page100.save.should == true
      page100.publication.section.id.should == section1.id
      page100.publication.slug.should == 'index'
      page100.path.should == "/section_one/index"

      page101.save.should == true
      page101.publication.section.id.should == section1.id
      page101.publication.slug.should == 'title_of_page_101'
      page101.path.should == "/section_one/title_of_page_101"

      page200.save.should == true
      page200.publication.section.id.should == section2.id
      page200.publication.slug.should == 'index'
      page200.path.should == "/section_two/index"

      page201.save.should == true
      page201.publication.section.id.should == section2.id
      page201.publication.slug.should == 'title_of_page_201'
      page201.path.should == "/section_two/title_of_page_201"
    end
  end
end
