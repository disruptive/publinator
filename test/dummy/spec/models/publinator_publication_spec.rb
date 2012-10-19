require 'spec_helper'
describe Publinator::Publication do
  describe "#create" do
    it "has a valid factory" do
      FactoryGirl.create(:page).publication.should be_valid
    end
  end

  describe "#content_item" do
    it "can return its publishable" do
      FactoryGirl.create(:page).should be_valid
      page = Publinator::Page.last
      publication = Publinator::Publication.last
      publication.publishable.id.should == page.id
      publication.publishable.class.should == Publinator::Page
    end
  end
end
