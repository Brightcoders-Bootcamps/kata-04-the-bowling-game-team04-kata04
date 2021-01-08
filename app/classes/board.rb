# frozen_string_literal: true

#
#   Class used control the Board
require_relative './rules'

# Board class
class Board
  attr_reader :board, :extra, :total_score

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
    calculate_scores(index)
    @total_score = @board[index][:total]
    extra?(hash_frame) if index == 9
  end

  def calculate_extra(roll)
    @total_score += roll
  end

  def calculate_scores(index)
    0.upto(index) do |index_cicle|
      get_total(index_cicle, Rules.get_type(@board[index_cicle]))
    end
  end

  private

  def extra?(frame)
    @extra = %i[spare strike].include?(Rules.get_type(frame)) ? 1 : 0
  end

  def get_total(index, type)
    case type
    when :strike
      calculate_strike(index)
    when :spare
      calculate_spare(index)
    else
      calculate_normal(index)
    end
  end

  def calculate_strike(index)
    score = @board[index - 1][:total] + 10
    next_frame = @board[index + 1]
    total_score = if Rules.get_type(next_frame) == :strike
                    score + (next_frame[:one] + @board[index + 2][:one])

                  else
                    score + (next_frame[:one] + next_frame[:two])
                  end
    @board[index][:total] = total_score
  end

  def calculate_spare(index)
    next_value = @board[index + 1][:one] unless @board[index + 1].nil?
    @board[index][:total] = @board[index - 1][:total] + 10 + next_value.to_i
  end

  def calculate_normal(index)
    frame = @board[index]
    score = @board[index - 1].nil? ? 0 : @board[index - 1][:total]
    @board[index][:total] = score + (frame[:one] + frame[:two])
  end
end
