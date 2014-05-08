require 'refinerycms-core'

module Refinery
  autoload :PageVideosGenerator, 'generators/refinery/page_videos_generator'

  module PageVideos

    class << self
      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join('spec', 'factories').to_s ]
      end


      def attach!
        require 'refinery/page'
        require 'refinery/page_videos/extension'
        require 'refinery/videos'
        config.enabled_models.each do |model_class_name|
          unless (model_class = model_class_name.safe_constantize)
            Rails.logger.warn "PageVideos is unable to find model class: #{model_class_name}"
            next
          end
          model_class.send :has_many_page_videos
        end

        Refinery::Videos::Video.send :has_many, :video_pages, :dependent => :destroy
        Decorators.register! root 
      end
    end

    require 'refinery/page_videos/engine'
  end
end
