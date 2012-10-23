require 'spec_helper'
module Publinator
  describe ApplicationHelper do
    describe "#li_tag" do
      it "should output an li tag with a submenu for a section" do
        page = FactoryGirl.create(:page, section: FactoryGirl.create(:section))
        li_tag(page.section).should == "<li id=\"pop_songs\"><a href=\"/pop_songs\">pop_songs</a><br><div class=\"submenu\" id=\"pop_songs\"><ul><li id=\"first_page\"><a href=\"/pop_songs/first_page\">First Page</a></li></ul></div></li>"
      end
      it "should output an li tag with a submenu for a product_type" do
        li_tag(FactoryGirl.create(:product).product_type).should == "<li id=\"widget_type\"><a href=\"/product_types/widget_type\">Widget Type</a><br><div class=\"submenu\" id=\"widget_type\"><ul><li id=\"first_product\"><a href=\"/products/first_product\">First Product</a></li></ul></div></li>"
      end
    end
  end
end
