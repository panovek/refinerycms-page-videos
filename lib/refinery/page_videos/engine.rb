require 'refinery/page_videos/configuration'

module Refinery
  module PageVideos
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery

      engine_name :refinery_page_videos

      def self.register(tab)
        tab.name = ::I18n.t(:'refinery.plugins.refinery_page_videos.tab_name')
        tab.partial = "/refinery/admin/pages/tabs/videos"
      end

      def self.initialize_tabs!
        PageVideos.config.enabled_tabs.each do |tab_class_name|
          unless (tab_class = tab_class_name.safe_constantize)
            Rails.logger.warn "PageVideos is unable to find tab class: #{tab_class_name}"
            next
          end
          tab_class.register { |tab| register tab }
        end
      end

      initializer "register refinery_page_videos plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "page_videos"
          plugin.hide_from_menu = true
        end
      end

      config.to_prepare do
        Refinery::PageVideos.attach!
      end

      config.after_initialize do
        initialize_tabs!
        Refinery.register_engine Refinery::PageVideos
      end

      #before_inclusion do
      #  Refinery::Plugin.register do |plugin|
      #    plugin.name = "page_videos"
      #    plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.page_videos_admin_page_videos_path }
      #    plugin.pathname = root
      #    plugin.activity = {
      #      :class_name => :'refinery/page_videos/page_video',
      #      :title => 'name'
      #    }

      #  end
      #end

      #config.after_initialize do
      #  Refinery.register_extension(Refinery::PageVideos)
      #end
    end
  end
end
