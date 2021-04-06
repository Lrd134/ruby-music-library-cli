class Genre
    extend Concerns::Findable
    attr_accessor :name, :artist
    @@all = []
    def initialize(name)
        @name = name
    end
    def save
        @@all << self
    end
    def self.all
        @@all
    end
    def self.create(name)
        new_genre = Genre.new(name)
        new_genre.save
        new_genre
    end
    def self.destroy_all
        @@all.clear
    end
    def songs
        Song.all.select { | song | song.genre == self }
    end
    def artists
        found = Song.all.collect do | song |
            if song.genre == self
                song.artist
            end

        end
        found.uniq
    end
    
end