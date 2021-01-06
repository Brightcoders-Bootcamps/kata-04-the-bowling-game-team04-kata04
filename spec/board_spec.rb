require 'rspec'
require '../app/classes/board.rb'
describe Board do
    it "the board is full" do
        board = Board.new
        expect(board.board).to eq([{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0}])
    end

    describe ".add_frame" do
        it "The board adds a frame" do
            board = Board.new
            board.add_frame({:one => 4, :two => 5, :total => 0}, 4)
            expect(board.board).to eq [{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 4, :two => 5, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0}]
        end
    end

    describe ".calculate_scores" do
        it "Calculates the scores of a board" do
            board = Board.new
            board.add_frame({:one => 4, :two => 5, :total => 0}, 0)
            board.add_frame({:one => 10, :two => 0, :total => 0}, 1)
            board.add_frame({:one => 4, :two => 6, :total => 0}, 2)
            expected = [{:one => 4, :two => 5, :total => 9},{:one => 10, :two => 0, :total => 29},{:one => 4, :two => 6, :total => 39},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0},{:one => 0, :two => 0, :total => 0}]
            board.calculate_scores
            expect(board.board).to eq expected
        end
    end
end