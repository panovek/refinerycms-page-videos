module Refinery
  module PageVideos
    module Extension
      def has_many_page_videos


        has_many :video_pages, :as => :page, :class_name => 'Refinery::VideoPage'#, :order => 'position ASC'
        has_many :videos, :through => :video_pages, :class_name => '::Refinery::Videos::Video'#, :order => 'position ASC'
        # accepts_nested_attributes_for MUST come before def images_attributes=
        # this is because images_attributes= overrides accepts_nested_attributes_for.

        accepts_nested_attributes_for :videos, :allow_destroy => false

        # need to do it this way because of the way accepts_nested_attributes_for
        # deletes an already defined videos_attributes
        module_eval do
          def videos_attributes=(data)
            data = data.reject {|key, data| data.blank?}
            ids_to_keep = data.map{|i, d| d['video_page_id']}.compact

            video_pages_to_delete = if ids_to_keep.empty?
              self.video_pages
            else
              self.video_pages.where(
                Refinery::PageVideos::VideoPage.arel_table[:id].not_in(ids_to_keep)
              )
            end

            video_pages_to_delete.destroy_all

            data.each do |i, video_data|
              video_page_id, video_id =
                video_data.values_at('video_page_id', 'id')

              next if video_id.blank?

              video_page = if video_page_id.present?
                self.video_pages.find(video_page_id)
              else
                self.video_pages.build(:video_id => video_id)
              end

              video_page.position = i
              video_page.save
            end
          end
        end

        include Refinery::PageVideos::Extension::InstanceMethods
      end

      module InstanceMethods

        def video_page_id_for_video_index(index)
          self.video_pages[index].try(:id)
        end
      end
    end
  end
end

ActiveRecord::Base.send(:extend, Refinery::PageVideos::Extension)
