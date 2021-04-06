class Artist
    extend Concerns::Findable
    attr_accessor :name, :song, :genre
    @@all = []
    def initialize(name)
        @name = name
        @song = []
    end
    def save
        @@all << self
    end
    def self.all
        @@all
    end
    def self.destroy_all
        @@all.clear
    end
    def self.create(name)
        new_artist = Artist.new(name)
        new_artist.save
        new_artist
    end

    def add_song(song)
        @song << song
        @song.uniq
        if song.artist.nil?
            song.artist = self
        end
        

        
    end
    def genres
        found = Song.all.collect do | song |
            if song.artist == self
                song.genre
            end

        end
        found.uniq
    end
    def songs
        Song.all.select { | song | song.artist == self }
    end
end