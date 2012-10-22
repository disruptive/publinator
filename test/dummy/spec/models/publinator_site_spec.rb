require 'spec_helper'
describe Publinator::Site do
  describe "#create" do
    it "has a valid factory" do
      FactoryGirl.build(:site).should be_valid
    end
  end
end
