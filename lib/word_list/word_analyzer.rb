module WordList
  class WordAnalyzer
    def initialize(word_list)
      @word_list = word_list
    end

    ALPHABET = "abcdefghijklmnopqrstuvwxyz".split('')
    
    def analyze
      word_list = @word_list.collect do |word|
        [word, word.split('').uniq, word.length]
      end.sort{|w1, w2| w2[2] <=> w1[2]}
      all_indices = (0...word_list.length).to_a
      longest_length = word_list[0][2]

      curr_word1, curr_word2, curr_prod = [], [], 0
      index = {}
      ALPHABET.each{|letter| index[letter] = []}
      word_list.each_with_index do |word, i|
        next if curr_prod / word[2] > longest_length
        word[1].each{|letter| index[letter] << i}
        j = best_pair(index, word[1], all_indices, i)
        next unless j
        word2 = word_list[j]
        if curr_prod < word[2] * word2[2]
          curr_word1, curr_word2, curr_prod = word, word2, word[2] * word2[2]
        end
      end
      [curr_word1[0], curr_word2[0]]
    end

    def best_pair(index, word, all_indices, current)
      not_pairs = []
      word.uniq.each do |letter|
        not_pairs = not_pairs + index[letter]
      end
      (all_indices[0...current] - not_pairs).first
    end

    def build_index(word_list)

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

    def current_words_have_lesser_product?(curr_product, word1, word2)
      curr_product < word1.length * word2.length
    end
  end
end