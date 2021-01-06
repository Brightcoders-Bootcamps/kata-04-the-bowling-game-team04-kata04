# frozen_string_literal: true

#
#   Class used control the Board
require './app/classes/rules'

class Board
  attr_reader :board

  def initialize
    @board = []
    init_board
  end

  def init_board
    (1..10).each do |_i|
      @board << { one: 0, two: 0, total: 0 }
    end
  end

  def add_frame(hash_frame, index)
    @board[index] = hash_frame
  end

  def calculate_scores
    @board.each_with_index do |frame, index|
      type = Rules.get_type(frame)
      get_total(frame, index, type)
    end
  end

  def get_total(_frame, index, type)
    calculate_strike(index) if type == :strike
    calculate_spare(index) if type == :spare
    calculate_normal(index) if type == :normal
  end

  def calculate_strike(index)
    @board[index][:total] = if Rules.get_type(@board[index + 1]) == :strike
                              (@board[index - 1][:total]) + 10 + (@board[index + 1][:one] + @board[index + 2][:two])
                            else
                              ((@board[index - 1][:total]) + 10) + (@board[index + 1][:one] + @board[index + 1][:two])
                            end
  end

  def calculate_spare(index)
    @board[index][:total] = @board[index - 1][:total] + 10 + @board[index + 1][:one]
  end

  def calculate_normal(index)
    @board[index][:total] = @board[index][:one] + @board[index][:two]
  end
end
