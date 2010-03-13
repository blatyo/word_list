module WordList
  class WordAnalyzer
    def initialize(word_list)
      @word_list = word_list
    end

    def analyze
      reverse_map = @word_list.collect{|word| word.split('').sort.join}
      word_list = reverse_map.sort
      index = build_index word_list

      curr_word1, curr_word2 = "", ""
      word_list[0...(word_list.length - 1)].each_with_index do |word1, i|
        word_list[(index[word1[0]]+1)...word_list.length].each do |word2|
          unless current_words_have_greater_product?(curr_word1, curr_word2, word1, word2)
            curr_word1, curr_word2 = word1, word2 unless share_common_letter?(word1, word2)
          end
        end
      end
      [@word_list[reverse_map.index(curr_word1)], @word_list[reverse_map.index(curr_word2)]] 
    end

    def build_index(word_list)
      index = {}
      word_list.each_with_index do |word, ind|
        index[word[0]] = ind 
      end
      index
    end

    def share_common_letter?(word1, word2)
      w1_iter = word1.each_char
      w2_iter = word2.each_char

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