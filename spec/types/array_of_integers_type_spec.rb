require "rails_helper"

RSpec.describe ArrayOfIntegersType do
  describe "#cast" do
    it "casts an array of strings to an array of integers" do
      input = ["1", "2", "3"]
      expected_output = [1, 2, 3]
      result = ArrayOfIntegersType.new.cast(input)
      expect(result).to eq(expected_output)
    end
  end
end
