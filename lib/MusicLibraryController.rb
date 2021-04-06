class MusicLibraryController
    attr_accessor :path
    ALPHABET = "abcdefghijklmnopqrstuvwxyz"
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
            case input
            when "list songs"
                list_songs
            when "list artists"
                list_artists
            when "list genres"
                list_genres
            when "list artist"
                list_songs_by_artist
            when "list genre"
                list_songs_by_genre
            when "play song"
                play_song
            end
        end
    end

    def list_songs

        sorted = Song.all.uniq.sort{ |a, b| a.name <=> b.name }
        
        sorted.each_with_index do | song, index | 
            puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end
    # def list_songs

    #     sorted = Song.all.uniq.sort{ |a, b| a.name <=> b.name }
        
    #     sorted.each_with_index do | song, index | 
    #         puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    #     end
    # end
    def list_artists

        sorted = Artist.all.uniq.sort{ |a, b| a.name <=> b.name }
        
        sorted.each_with_index do | artist, index | 
            puts "#{index + 1}. #{artist.name}"
        end
    end
    def list_genres

        sorted = Genre.all.uniq.sort{ |a, b| a.name <=> b.name }
        
        sorted.each_with_index do | genre, index | 
            puts "#{index + 1}. #{genre.name}"
        end
    end
    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip
        found = Artist.all.uniq.find { | obj | obj.name == input}
        if found != nil
            found = found.songs.uniq.sort { |a, b| a.name <=> b.name }
            found.each_with_index do | songs, index |
                # binding.pry

                puts "#{index + 1}. #{songs.name} - #{songs.genre.name}" 
            end
        end
            
        

    end
    
    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip
        found = Genre.all.uniq.find { | obj | obj.name == input}
        if found != nil
            # binding.pry
            found = found.songs.uniq.sort { |a, b| a.name <=> b.name }
            found.each_with_index do | songs, index| 
                puts "#{index + 1}. #{songs.artist.name} - #{songs.name}" 
            end
        end

    end
    def play_song
        
        puts "Which song number would you like to play?"
        input = gets.strip
        if input.to_i < Song.all.uniq.size && input.to_i >= 1
                
            sorted = Song.all.uniq.sort{ |a, b| a.name <=> b.name }

            if sorted[input.to_i - 1] != nil
                puts "Playing #{sorted[input.to_i - 1].name} by #{sorted[input.to_i - 1].artist.name}"
            end
        end

        
    end
    
end