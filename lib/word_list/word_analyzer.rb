module WordList
  class WordAnalyzer
    def initialize(word_list)
      @word_list = word_list
    end

    def analyze
      curr_word1, curr_word2 = nil, nil
      @word_list.each do |word1|
        @word_list.each do |word2|
          if word1 != word2 && !share_common_letter?(word1, word2)
            curr_word1, curr_word2 = word1, word2 if (!curr_word1 && !curr_word2) ||
              !current_words_have_greater_product?(curr_word1, curr_word2, word1, word2)
            puts "#{curr_word1} #{curr_word2}"
          end
        end
      end
      [curr_word1, curr_word2]
    end

    def share_common_letter?(word1, word2)
      word1.each_char do |char|
        return true if word2.include? char
      end
      false
    end

    def current_words_have_greater_product?(curr_word1, curr_word2, word1, word2)
      (curr_word1.length * curr_word2.length) > (word1.length * word2.length)
    end
  end
end