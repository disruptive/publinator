FactoryGirl.define do
  factory :article do
    title       "First Article"
    body        "Article Text is here. Right here in the factory."
  end

  factory :domain_name, :class => "Publinator::DomainName" do
    name        'example.com'
    shared      true
    default     true
    association :site
  end

  factory :section, :class => "Publinator::Section" do
    name        'pop_songs'
    layout      false
    association :site
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
