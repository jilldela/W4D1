# == Schema Information
#
# Table name: visits
#
#  id         :integer          not null, primary key
#  url_id     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Visit < ApplicationRecord
  validates :url_id, :user_id, presence: true

  def self.record_visit!(user, shortened_url)
    Visit.create(url_id: shortened_url.id, user_id: user.id)
  end

  belongs_to :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id

  belongs_to :url,
    class_name: "ShortenedUrl",
    primary_key: :id,
    foreign_key: :url_id
end
