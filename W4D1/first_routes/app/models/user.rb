# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true

  has_many :artwork_shares,
    primary_key: :id,
    foreign_key: :viewer_id,
    class_name: 'ArtworkShare'

  has_many :artworks,
    dependent: :destroy,
    primary_key: :id,
    foreign_key: :artist_id,
    class_name: 'Artwork'

  has_many :shared_artworks,
    through: :artworks,
    source: :artwork_shares
end
