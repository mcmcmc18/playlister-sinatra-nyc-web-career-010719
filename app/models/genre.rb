class Genre < ActiveRecord::Base

  ###confused about this
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

  # has_many :artists, through: :songs

  def slug
    self.name.gsub(' ','-').downcase
  end

  def self.find_by_slug(name)
    Genre.all.find do |genre|
      genre.slug == name
    end
  end
end
