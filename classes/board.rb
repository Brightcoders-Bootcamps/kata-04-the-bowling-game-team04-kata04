# frozen_string_literal: true

#
#   Class used control the Board
require_relative './rules'

# Board class
class Board
  attr_reader :board, :extra

  def initialize
    @board = []
    @total_score = 0
    init_board
    @extra = 0
  end

  def init_board
    (1..10).each do |_i|
      @board << { one: 0, two: 0, total: 0 }
    end
  end

  def add_frame(hash_frame, index)
    @board[index] = hash_frame
    calculate_scores
    extra?(hash_frame) if index == 9
  end

  def calculate_extra(roll)
  @board[9][:total]= @board[9][:one] + @board[9][:two] + roll
  end

  def calculate_scores
    @board.each_with_index do |frame, index|

      get_total(index, Rules.get_type(frame))
    end
  end

  private

  def extra?(frame)
    @extra = %i[spare strike].include?(Rules.get_type(frame)) ? 1 : 0
  end

  def get_total(index, type)
    calculate_strike(index) if type == :strike
    calculate_spare(index) if type == :spare
    calculate_normal(index) if type == :normal
  end

  def calculate_strike(index)
    score = @board[index - 1][:total] + 10
    next_frame = @board[index + 1]
    total_score = 0
    if Rules.get_type(next_frame) == :strike
      total_score = score + (next_frame[:one] + @board[index + 2][:one])
    else
      total_score = score + (next_frame[:one] + next_frame[:two])
    end
    @board[index][:total] = total_score
  end

  def calculate_spare(index)
    next_value = @board[index + 1][:one] unless @board[index + 1].nil?
    @board[index][:total] = @board[index - 1][:total] + 10 + next_value.to_i
  end

  def calculate_normal(index)
    frame = @board[index]
    @board[index][:total] = frame[:one] + frame[:two]
  end
end
