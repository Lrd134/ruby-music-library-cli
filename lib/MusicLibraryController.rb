class MusicLibraryController
    attr_accessor :path
    def initialize(path = "./db/mp3s")
        @path = path
        created = MusicImporter.new(@path)
        created.import
    end
    def call
        input = "go"
        until input == "exit"
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'." 
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"
            input = gets.strip
        end
    end
    def list_songs
        sorted = []
       
        sorted = Song.all
        sorted = sorted.sort_by { | song | [song.name] } 
        
        sorted.each_with_index do | song, index | 
            puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

end