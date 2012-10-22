FactoryGirl.define do
  factory :article do
    title       "First Article"
    body        "Article Text is here. Right here in the factory."
    association :site
  end

  factory :asset_item, :class => "Publinator::AssetItem" do
    asset       File.new("#{Rails.root}/spec/sample_files/jerry135x135.jpg", 'r')
    association :assetable, factory: :article
  end

  factory :domain_name, :class => "Publinator::DomainName" do
    name        'example.com'
    shared      true
    default     true
    association :site
  end

  factory :product do
    title       "First Product"
    body        "Product Text is here. Right here in the factory."
    association :site
    association :product_type
  end

  factory :product_type do
    title       "First Product"
    body        "Product Text is here. Right here in the factory."
    association :site
  end

  factory :publishable_type, :class => "Publinator::PublishableType" do
    name        "Article"
  end

  factory :section, :class => "Publinator::Section" do
    name          'pop_songs'
    layout        false
    section_slug  'pop_songs'
    association   :site
  end

  factory :site, :class => "Publinator::Site" do
    name        "dummy"
    default     true
    abbr        "application"
  end

  factory :page, :class => "Publinator::Page" do
    title       "First Page"
    body        "Page Text is here. Right here in the factory."
    association :site
  end
end
