# == Schema Information
#
# Table name: tag_topics
#
#  id         :integer          not null, primary key
#  topic      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TagTopic < ApplicationRecord
  validates :topic, presence: true

  has_many :taggings,
    class_name: "Tagging",
    primary_key: :id,
    foreign_key: :tag_id

  has_many :tagged_urls,
    through: :taggings,
    source: :url

  def popular_links
    result = tagged_urls.sort_by { |url| url.num_clicks }.reverse
    result.map {|url| [url.long_url, url.num_clicks] }
  end
end
