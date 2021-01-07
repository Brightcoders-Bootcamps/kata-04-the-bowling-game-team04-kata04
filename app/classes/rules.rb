# frozen_string_literal: true

#
#   Class used to control the rules of the
#   bowling game
class Rules
  def self.get_type(frame)
    type = :strike if strike?(frame)
    type = :spare if spare?(frame)
    type = :normal if normal?(frame)
    type
  end

  def self.normal?(frame)
    return true if frame[:one] + frame[:two] < 10
  end

  def self.strike?(frame)
    return true if frame[:one] == 10
  end

  def self.spare?(frame)
    return true if (frame[:one] + frame[:two] == 10) && (frame[:one] != 10)
  end

  def self.extra?(frame)
    type = get_type(frame)
    %i[strike spare].include?(type) ? true : false
  end
end
