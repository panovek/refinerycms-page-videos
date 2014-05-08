# Page Videos Engine for Refinery CMS

## About

Page Videos allows you to relate one or more videos to any page in Refinery which makes it really easy for you to create simple video galleries on the front end page views. This is based on [zuf/refinerycms-videojs](https://github.com/zuf/refinerycms-videojs)
and inspired by [refinery/refinerycms-page-images](https://github.com/refinery/refinerycms-page-images)

## Requirements

* refinerycms >= 2.1.0
* refinerycms-videojs, 'master'

## Features

* Ability to select one or more videos from the video picker and relate them to a page
* Reordering support, simply drag into order (TODO)

## Install

Add this line to your applications `Gemfile`

```ruby
gem 'refinerycms-videojs', github: 'zuf/refinerycms-videojs'
gem 'refinerycms-page_videos', github: 'geekcups-team/refinerycms-page-videos', branch:'2.1-stable'
```

Next run

```bash
bundle install
rails generate refinery:page_videos
rails generate refinery:videos
rake db:migrate
```

Now when you start up your Refinery application, edit a page and there should be a new "Videos" tab.

## Usage

`app/views/refinery/pages/show.html.erb`

If you don't have this file then Refinery will be using its default. You can override this with

```bash
rake refinery:override view=refinery/pages/show
```

```erb
<% content_for :body_content_right do %>
  <ul id='gallery'>
    <% @page.videos.each do |video| %>
      <%= video.to_html %>
   <% end %>
  </ul>
<% end %>
<%= render :partial => "/refinery/content_page" %>
```
