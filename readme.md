# Page Videos extension for Refinery CMS.

gem 'refinerycms-videojs', github: 'zuf/refinerycms-videojs'
## How to build this extension as a gem

    cd vendor/extensions/page_videos
    gem build refinerycms-page_videos.gemspec
    gem install refinerycms-page_videos.gem

    # Sign up for a http://rubygems.org/ account and publish the gem
    gem push refinerycms-page_videos.gem
