# == Schema Information
#
# Table name: feeds
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  url        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Feed < ActiveRecord::Base
  validates_presence_of :name, :url
  validates :url, presence: true

  def fetch_and_parse
    Rails.cache.fetch('feed', expires_in: 900) do 
      Feedjira::Feed.fetch_and_parse url
    end
  end

  def latest_post
    fetch_and_parse.entries.first
  end

  def latest_title_and_link
    post = latest_post
    [post.title, post.url]
  end
end