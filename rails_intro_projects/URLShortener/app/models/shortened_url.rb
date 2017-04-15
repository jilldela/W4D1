require 'securerandom'

# == Schema Information
#
# Table name: shortened_urls
#
#  id         :integer          not null, primary key
#  long_url   :string
#  short_url  :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :long_url, presence: true, uniqueness: true
  validate :no_spamming
  validate :nonpremium_max

  belongs_to :submitter,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id

  has_many :visits,
    class_name: "Visit",
    primary_key: :id,
    foreign_key: :url_id

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :user

  has_many :taggings,
    class_name: "Tagging",
    primary_key: :id,
    foreign_key: :url_id

  has_many :tag_topics,
    through: :taggings,
    source: :tag

  def num_clicks
    visits.count
  end

  def num_uniq
    visitors.count
  end

  def num_recent_uniques
    recents = visitors.select { |visitor| Time.now - visitor.created_at < 600 }
    recents.count
  end

  def self.random_code
    code = nil
    while code.nil? || ShortenedUrl.exists?(short_url: code)
      code = SecureRandom.urlsafe_base64[0...16]
    end
    code
  end

  def self.create!(user, long_url)
    code = ShortenedUrl.random_code
    ShortenedUrl.create(long_url: long_url, short_url: code, user_id: user.id)
  end

  def no_spamming
    if submitter.submitted_urls.count > 5 &&
      Time.now - submitter.submitted_urls[-5].created_at < 60
      errors[:base] << "No spamming"
      puts "No spammin"
    end
  end

  def nonpremium_max
    if submitter.submitted_urls.count > 5 && submitter.premium = false
      errors[:base] << "Reached maximum submission limit"
      puts "Reached maximum submission limit"
    end
  end
end
