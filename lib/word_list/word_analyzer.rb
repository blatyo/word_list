module WordList
  class WordAnalyzer
    def initialize(word_list)
      @word_list = word_list
    end
    
    def analyze
      word_list = @word_list.sort do |w1, w2|
        (w2[2] ||= w2[0].length) <=> (w1[2] ||= w1[0].length)
      end
      all_indices = (0...word_list.length).to_a
      longest_length = word_list[0][2]

      curr_word1, curr_word2, curr_prod = [], [], 0
      index = {'a' => [],'b' => [],'c' => [],'d' => [],'e' => [],'f' => [],'g' => [],'h' => [],'i' => [],'j' => [],
               'k' => [],'l' => [],'m' => [],'n' => [],'o' => [],'p' => [],'q' => [],'r' => [],'s' => [],'t' => [],
               'u' => [],'v' => [],'w' => [],'x' => [],'y' => [],'z' => [],'skip' => []}
      word_list.each_with_index do |word, i|
        if (beat = curr_prod / word[2]) > longest_length
          index['skip'] << i
          next
        end
        (word[1] = word[0].split('').uniq).each{|letter| index[letter] << i}
        j = best_pair(index, word[1], all_indices, i)
        next unless j
        if word_list[j][2] < beat
          index['skip'] << j
          next
        end
        curr_word1, curr_word2, curr_prod = word, word_list[j], word[2] * word_list[j][2]
      end
      [curr_word1[0], curr_word2[0]]
    end

    def best_pair(index, word, all_indices, current)
      not_pairs = index['skip']
      word.uniq.each do |letter|
        not_pairs = not_pairs + index[letter]
      end
      (all_indices[0...current] - not_pairs).first
    end
  end
end