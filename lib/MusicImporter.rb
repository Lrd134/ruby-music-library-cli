
class MusicImporter
    attr_accessor :path, :files
    
    def initialize(filepath)
        @path = filepath
    end
    def files
        

        @files = Dir["#{@path}/*"]
        @files.each do | obj |
            obj.slice! "#{@path}/"
        end

        @files
    end
    def import
        
        files
        @files.each do | obj |
            Song.create_from_filename(obj)
        end
    end
end