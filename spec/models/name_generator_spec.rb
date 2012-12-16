require 'spec_helper'

describe NameGenerator do
  describe "#generate" do
    it "returns a random string with 5 character" do
      generated_number = NameGenerator.generate
      expect(generated_number).to match(/^\w{6}$/)
    end
  end
end
