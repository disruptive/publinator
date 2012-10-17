require 'spec_helper'
describe Publinator::DomainName do
  describe "#create" do    
    it "has a valid factory" do
      FactoryGirl.build(:domain_name).should be_valid
    end
  end
  describe "#get_by_domain_name" do
    it "should return dummy for dummy.dev" do
      @request = ActionDispatch::TestRequest.new
      @request.stub(:domain).and_return("dummy.dev")
      @domain_name = Publinator::DomainName.get_by_domain_name(@request)
      @domain_name.name.should == "dummy.dev"
      @domain_name.site.name.should == "dummy"
    end
    it "should return silly for silly.dummy.dev" do
      @request = ActionDispatch::TestRequest.new
      @request.stub(:domain).and_return("dummy.dev")
      @request.stub(:subdomain).and_return("silly")
      @domain_name = Publinator::DomainName.get_by_domain_name(@request)
      @domain_name.name.should == "dummy.dev"
      @domain_name.subdomain.should == "silly"
      @domain_name.site.name.should == "silly"
    end
  end
end