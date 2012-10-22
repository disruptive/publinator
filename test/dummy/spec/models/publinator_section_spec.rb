require 'spec_helper'
describe Publinator::Section do
  describe "#create" do
    it "has a valid factory" do
      FactoryGirl.build(:section).should be_valid
    end
  end
  describe "#index_item" do
    before do
      site                = FactoryGirl.create(:site)
      section             = FactoryGirl.create(:section, site: site)
      page100             = Publinator::Page.new(title: "Title of Page 100", body: "Body of Page 100", site: site, section: section, :default => true)
      page101             = Publinator::Page.new(title: "Title of Page 101", body: "Body of Page 101", site: site, section: section)
      page100.save
      page101.save
    end
    it "can find its index publication" do
      idx_item = Publinator::Section.last.index_item
      idx_item.publishable.class.should == Publinator::Page
    end
    it "can get the publishable of its index publication" do
      idx_item = Publinator::Section.last.index_item
      idx_item.publishable.title.should == "Title of Page 100"
    end
  end
end
