require 'rspec'
require './app/classes/board.rb'

describe Board do
  describe ".add_frame" do
    it "The board adds a frame" do
      board = Board.new
      board.add_frame({:one => 4, :two => 5, :total => 0}, 4)
      expectedBoard = [{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 4, :two => 5, :total => 9},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0}]
      expect(board.board).to eq expectedBoard
    end
  end

  describe ".calculate_scores" do
    it "Calculates the scores of a board" do
      board = Board.new
      board.add_frame({:one => 4, :two => 5, :total => 0}, 0)
      board.add_frame({:one => 10, :two => 0, :total => 0}, 1)
      board.add_frame({:one => 10, :two => 0, :total => 0}, 2)
      board.add_frame({:one => 4, :two => 6, :total => 0}, 3)
      expectedScore = [{:one => 4, :two => 5, :total => 9},{:one => 10, :two => 0, :total => 33},{:one => 10, :two => 0, :total => 53},{:one => 4, :two => 6, :total => 63},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0}, {:one => 0, :two => 0, :total => 0}]
      expect(board.board).to eq expectedScore
    end
  end
