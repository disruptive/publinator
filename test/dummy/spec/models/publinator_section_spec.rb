require 'spec_helper'
describe Publinator::Section do
  describe "#create" do
    it "has a valid factory" do
      FactoryGirl.create(:section).should be_valid
    end
  end
end