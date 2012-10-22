#module Publinator
  class Publinator::AssetItem < ActiveRecord::Base
    attr_accessible :asset, :assetable, :asset_type
    belongs_to :assetable, :polymorphic => true
    validates_presence_of :assetable

    has_attached_file :asset
  end
#end
