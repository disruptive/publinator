require 'spec_helper'
describe Publinator::Page do
  describe "#create" do
    it "has a valid factory" do
      FactoryGirl.create(:page).should be_valid
    end
  end
end