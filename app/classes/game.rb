# frozen_string_literal: true

require_relative './board'
#   Class for interact with players.
class Game
  def initialize
    @board_father = Board.new
    @board_child = @board_father.board
    display_points
    automatic_mode
  end

  private

  def automatic_mode
    @board_child.each_with_index do |frame, index|
      question_shoot(frame, index)
      question_extra_shoot if index == 9 && @board_father.extra == 1
      display_points
    end
  end

  def question_shoot(frame, index)
    frame.each_with_index do |_shoot, shoot_index|
      next unless shoot_index < 2 && frame[:one] != 10
      puts 'Press any key for shoot'
      frame[frame.keys[shoot_index]] = gets.chomp.to_i
    end
    @board_father.add_frame(frame, index)
  end

  def question_extra_shoot
    puts ' ¡You have a extra shoot!, Press any key for shoot'
    @board_father.calculate_extra(gets.chomp.to_i)
  end

  def display_points
    clear_display
    print "PUNTAJES \n====================================================\n"
    @board_child.each_with_index { |frame, index| print_with_colours(index, frame) }
    print "==================================================== \n Score total #{@board_father.total_score}\n \n"
  end

  def print_with_colours(index, frame)
    if (frame[:two]).positive?
      set_color(index, frame, "\e[0;32m")
    elsif (frame[:one]).positive?
      set_color(index, frame, "\e[0;33m")
    else
      set_color(index, frame, "\e[0;37m")
    end
  end

  def set_color(index, frame, color)
    # puts frame
    puts "| Frame number #{index + 1} => #{color} shoot one: #{frame[:one]}" \
      " shoot two #{frame[:two]} total: #{frame[:total]}| \e[0m"
  end

  def clear_display
    Gem.win_platform? ? (system 'cls') : (system 'clear')
  end
end

Game.new
