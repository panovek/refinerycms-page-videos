
FactoryGirl.define do
  factory :page_video, :class => Refinery::PageVideos::PageVideo do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

