module Concerns

    module Findable
        def find_by_name(name)
            self.all.detect { |a| a.name == name}
        end
        def find_or_create_by_name(name) 
            find_by_name(name).nil? ? self.create(name) : find_by_name(name)
        end
    end

end