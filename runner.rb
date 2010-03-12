path = File.dirname(__FILE__)
require path + '/lib/word_list'

word1, word2 = WordList.run(path + '/spec/fixtures/word.lst')
puts <<HERE
Of the pairs of words in the given dictionary that have no letters in common,
the pair that maximizes the product of the words' lengths are:
#{word1} and #{word2}.
HERE