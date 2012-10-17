require 'spec_helper'
describe Publinator::Publishable do
  describe "#create" do    
    it "has a valid factory" do
      FactoryGirl.build(:article).should be_valid
    end
  end
end