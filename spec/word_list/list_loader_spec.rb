require 'spec_helper'

module WordList
  describe ListLoader do
    describe "#parse" do
      it "should parse a list of words and produce an array of those words" do
        fixture = File.dirname(__FILE__) + "/../fixtures/simple.lst"
        ListLoader.parse(fixture).should == ["aaa", "list", "simple"]
      end
    end
  end
end