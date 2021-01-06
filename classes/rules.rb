class Rules

    def self.get_type(frame)
        type = :strike if self.strike?(frame)
        type = :spare if self.spare?(frame)
        type = :normal if self.normal?(frame)
        type
    end

    def self.normal?(frame)
        return true if frame[:one] + frame[:two] < 10 
    end

    def self.strike?(frame)
        return true if frame[:one] == 10
    end

    def self.spare?(frame)
        return true if (frame[:one] + frame[:two] == 10 ) && (frame[:one] != 10)
    end

end