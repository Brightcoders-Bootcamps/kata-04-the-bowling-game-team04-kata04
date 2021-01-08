require "rspec"
require "./app/classes/rules.rb"

describe Rules do
  describe ".get_type" do
    it "Returns strike type" do
      strike = {:one => 10, :two => 0, :total => 0}
      expect(Rules.get_type(strike)).to eq :strike
    end
    it "Returns spare type" do
      spare = {:one => 4, :two => 6, :total => 0}
      expect(Rules.get_type(spare)).to eq :spare
    end
    it "Returns normal type" do
      normal = {:one => 4, :two => 2, :total => 0}
      expect(Rules.get_type(normal)).to eq :normal
    end
  end
end