# == Schema Information
#
# Table name: castings
#
#  id       :integer          not null, primary key
#  movie_id :integer          not null
#  actor_id :integer          not null
#  ord      :integer          not null
#

class Casting < ActiveRecord::Base

  belongs_to :actor,
    class_name: "Actor",
    foreign_key: :actor_id,
    primary_key: :id

  belongs_to :movie,
    class_name: "Movie",
    foreign_key: :movie_id,
    primary_key: :id

end
