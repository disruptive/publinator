require 'spec_helper'
describe Product do
  describe "#create" do
    it "has a valid factory" do
      FactoryGirl.create(:product).should be_valid
    end
  end
end
