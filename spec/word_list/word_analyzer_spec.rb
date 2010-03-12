require "spec_helper"

module WordList
  describe WordAnalyzer do
    before :each do
      fixture = File.dirname(__FILE__) + "/../fixtures/simple.lst"
      @word_analyzer = WordAnalyzer.new ListLoader.parse(fixture) 
    end

=begin
    describe "#analyze" do
      it "should find two words that share no letters in common" do
        @word_analyzer.analyze.should == ['aaa', 'simple']
      end
    end
=end

    describe "#share_common_letter?" do
      it "should return true if the words share a common letter" do
        @word_analyzer.share_common_letter?("abcdefgh", "ijklmnoph").should == true
      end

      it "should return false if the words do not share a common letter" do
        @word_analyzer.share_common_letter?("abcdefgh", "ijklmnop").should == false
      end
    end

    describe "#current_words_have_greater_product?" do
      it "should return true if current words have a greater product" do
        @word_analyzer.current_words_have_greater_product?("aa", "bb", "a", "b").should == true
      end

      it "should return false if current words have a lesser product" do
        @word_analyzer.current_words_have_greater_product?("a", "b", "aa", "bb").should == false
      end
    end
  end
end