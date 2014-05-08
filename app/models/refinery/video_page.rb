module Refinery
  class VideoPage < Refinery::Core::BaseModel

    belongs_to :video, :class_name => "::Refinery::Videos::Video"
    belongs_to :page, :polymorphic => true

    attr_accessible :video_id, :position, :locale
  end
end
