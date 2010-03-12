module WordList
  class WordAnalyzer
    def initialize(word_list)
      @word_list = word_list
    end

    def analyze
      word_list = @word_list.collect{|word| word.split('').sort}

      curr_word1, curr_word2 = nil, nil
      word_list.each_with_index do |word1, i|
        word_list[i...word_list.length].each_with_index do |word2, j|
          if word1 != word2 && !share_common_letter?(word1, word2)
            curr_word1, curr_word2 = word1, word2 if (!curr_word1 && !curr_word2) ||
              !current_words_have_greater_product?(curr_word1, curr_word2, word1, word2)
          end
        end if i < word_list.length - 1
      end
      [@word_list[word_list.index(curr_word1)], @word_list[word_list.index(curr_word2)]] 
    end

    def share_common_letter?(word1, word2)
      w1_iter = word1.each
      w2_iter = word2.each

      c1 = w1_iter.next
      c2 = w2_iter.next
      while(true)
        begin
          if c1 == c2
            return true
          elsif c1 < c2
            c1 = w1_iter.next
          else
            c2 = w2_iter.next
          end
        rescue
          return false
        end
      end
    end

    def current_words_have_greater_product?(curr_word1, curr_word2, word1, word2)
      (curr_word1.length * curr_word2.length) > (word1.length * word2.length)
    end
  end
end