# == Schema Information
#
# Table name: taggings
#
#  id         :integer          not null, primary key
#  url_id     :integer
#  tag_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tagging < ApplicationRecord
  belongs_to :tag,
    class_name: "TagTopic",
    primary_key: :id,
    foreign_key: :tag_id

  belongs_to :url,
    class_name: "ShortenedUrl",
    primary_key: :id,
    foreign_key: :url_id
end
