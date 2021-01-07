# frozen_string_literal: true

require_relative './board'
#   Class for interact with players.
class Game
  def initialize
    @boardFather = Board.new
    @boardChild = @boardFather.board
    display_points
    automatic_mode
  end

  private

  def automatic_mode
    @boardChild.each_with_index do |frame, index|
      
      question_shoot(frame, index)
      question_extra_shoot if index == 9 && @boardChild.extra == 1
      display_points

    end
  end

  def question_shoot(frame, index)
  	frame.each_with_index do |_shoot, shoot_index|
        if shoot_index < 2
        	puts 'Press any key for shoot'
        	frame[frame.keys[shoot_index]] = gets.chomp.to_i
        	display_points
        end
      end
      @boardFather.add_frame(frame, index)

  end

  def question_extra_shoot
    puts ' ¡You have a extra shoot!, Press any key for shoot'
    @boardFather.calculate_extra(gets.chomp.to_i)

  end

  def display_points
  	clear_display
    print "PUNTAJES \n====================================================\n"
    @boardChild.each_with_index { |frame, index|  print_with_colours(index, frame) }
    print "==================================================== \n Score total #{@boardChild.map { |frame_object| frame_object[:total] }.reduce(:+)}\n \n"
  end

  def print_with_colours(index, frame)
    if (frame[:two] > 0) 
      set_color(index, frame, "\e[0;32m")
    elsif (frame[:one] > 0)
       set_color(index, frame, "\e[0;33m")
    else
      set_color(index, frame, "\e[0;37m")
    end
  end
  def set_color(index, frame, color)
  	puts "| Frame number #{index + 1} => #{color} shoot one: #{frame[:one]}" \
      " shoot two #{frame[:two]} total: #{frame[:total]}| \e[0m"
  end


  def clear_display
    Gem.win_platform? ? (system 'cls') : (system 'clear')
  end
end

Game.new
