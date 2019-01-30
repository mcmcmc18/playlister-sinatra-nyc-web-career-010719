class Artist < ActiveRecord::Base

  has_many :songs
  has_many :genres, through: :songs


  # def slug
  #   self.name.gsub!(/[^A-Za-z]/,'-').downcase
  # end

  def slug
    self.name.gsub(' ','-').downcase
  end

  def self.find_by_slug(name)
    Artist.all.find do |artist|
      artist.slug == name
    end
  end
end
