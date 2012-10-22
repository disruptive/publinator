require 'spec_helper'
describe Publinator::PublishableType do
  describe "#create" do
    it "has a valid factory" do
      FactoryGirl.build(:publishable_type).should be_valid
    end
  end
  describe "self#matches?" do
    it "should return true for Articles" do
      FactoryGirl.create(:publishable_type, name: 'Article')
      @request = ActionDispatch::TestRequest.new
      @request.path_parameters[:publishable_type] = 'articles'
      Publinator::PublishableType.matches?(@request).should be_true
    end
  end
end

