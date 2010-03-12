path = File.dirname(__FILE__)
require path + '/word_list/list_loader'
require path + '/word_list/word_analyzer'

module WordList
  def self.run(file)
    WordAnalyzer.new(ListLoader.parse(file)).analyze
  end
end