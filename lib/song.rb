class Song
    attr_accessor :name
    attr_reader :artist, :genre
    @@all = []  
    def initialize(song, artist = nil, genre = nil)

        @name = song
        self.artist= artist
        self.genre= genre
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
    
    def self.create(song)
        new_song = Song.new(song)
        new_song.save
        new_song
    end
    def artist=(artist)
        # binding.pry
        if !artist.nil?
            if !artist.song.include?(self)
            
                artist.add_song(self)
            end
        end

        @artist = artist

        
    end
    def genre=(genre)
        if @genre != genre
            @genre = genre
        end
    end
    def self.find_by_name(name)
        self.all.find { | song | song.name == name}
    end
    def self.find_or_create_by_name(name) 
        find_by_name(name).nil? ? self.create(name) : find_by_name(name)
    end
    def self.new_from_filename(filename) 
        
        filename = filename.chomp(".mp3").split(" - ")
          
        
        made = self.find_or_create_by_name(filename[1])

        # self.new(filename[1], Artist.new(filename[0]), Genre.new(filename[2]))
        made.artist = Artist.find_or_create_by_name(filename[0])
        made.genre = Genre.find_or_create_by_name(filename[2])
        made
    end
    def self.create_from_filename(filename)
        created = self.new_from_filename(filename)
        created.save

    end
    
    # def self.artist=(artist)
    #     artist.add_song(self)
    # end
end