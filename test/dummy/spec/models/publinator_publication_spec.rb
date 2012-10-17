require 'spec_helper'
describe Publinator::Publication do
  describe "#create" do
    it "has a valid factory" do
      FactoryGirl.create(:publication).should be_valid
    end
  end
end