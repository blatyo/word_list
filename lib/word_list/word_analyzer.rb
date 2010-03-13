module WordList
  class WordAnalyzer
    def initialize(word_list)
      @word_list = word_list
    end

    ALPHABET = "abcdefghijklmnopqrstuvwxyz".split('')
    
    def analyze
      word_list = @word_list.collect{|word| word.split('').sort}
      index = build_index word_list
      all_indices = (0...word_list.length).to_a

      curr_word1, curr_word2 = "", ""
      word_list[0...(word_list.length - 1)].each_with_index do |word1, i|
        possible_pairs(index, word1, all_indices, i).each do |j|
          unless current_words_have_greater_product?(curr_word1, curr_word2, word1, word_list[j])
            curr_word1, curr_word2 = word1, word_list[j]
          end
        end
      end
      [@word_list[word_list.index(curr_word1)], @word_list[word_list.index(curr_word2)]] 
    end

    def possible_pairs(index, word, all_indices, i)
      not_pairs = []
      word.uniq.each do |letter|
        not_pairs = not_pairs + index[letter]
      end
      all_indices[(i+1)...all_indices.length] - not_pairs
    end

    def build_index(word_list)
      index = {}
      ALPHABET.each{|letter| index[letter] = []}
      word_list.each_with_index do |word, i|
        word.each{|letter| index[letter] << i}
      end
      index
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