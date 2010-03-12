module WordList
  class ListLoader
    def self.parse(file)
      word_list = []
      File.foreach(file) do |line|
        word_list << line.strip
      end
      word_list
    end
  end
end