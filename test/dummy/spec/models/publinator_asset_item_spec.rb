require 'spec_helper'
describe Publinator::AssetItem do
  describe "#create" do
    it "has a valid factory" do
      ai = FactoryGirl.create(:asset_item)
      ai.should be_valid
      p ai.asset.to_yaml
      p ai.asset.url
      p Publinator::AssetItem.last.asset.url
    end

    it "can be created with a fixture" do
      ai = Publinator::AssetItem.new(:asset => File.new(Rails.root + 'spec/sample_files/jerry135x135.jpg'), assetable: FactoryGirl.create(:article))
      ai.save.should == true
      ai.should be_valid
      p ai.asset.to_yaml
    end
  end
end

