#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  #Implement the following read-only attributes in the LineAnalyzer class.

  #* highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
  def highest_wf_count
    @highest_wf_count
  end

  #* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  def highest_wf_words
    @highest_wf_words = Array.new
  end

  #* content          - the string analyzed (provided)
  def content
    @content
  end

  #* line_number      - the line number analyzed (provided)
  def line_number
    @line_number
  end

  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  #Add the following methods in the LineAnalyzer class.
  #* initialize() - taking a line of text (content) and a line number
  #* calculate_word_frequency() - calculates result

  #Implement the initialize() method to:
  #* take in a line of text and line number
  #* initialize the content and line_number attributes
  #* call the calculate_word_frequency() method.
  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    @highest_wf_count = 0
    @highest_wf_words =  Array.new
    self.calculate_word_frequency()

  end

  #Implement the calculate_word_frequency() method to:
  #* calculate the maximum number of times a single word appears within
  #  provided content and store that in the highest_wf_count attribute.
  #* identify the words that were used the maximum number of times and
  #  store that in the highest_wf_words attribute.
  def calculate_word_frequency()
    @highest_wf_words = Array.new
    words = self.content.downcase.tr(",.?!",'').split(' ')
    #p words
    counts = words.each_with_object(Hash.new(0)) { |e, h| h[e] += 1 }
    @highest_wf_count = counts.values.max
    top_words = counts.select { |k, v| v == @highest_wf_count }.keys
    top_words.each do |topword|
      if !@highest_wf_words.include?(topword)
        @highest_wf_words<< topword
      end
    end
  end

end

#  Implement a class called Solution. 
class Solution

  # Implement the following read-only attributes in the Solution class.

  #* analyzers - an array of LineAnalyzer objects for each line in the file
  @analyzers = []

  #* highest_count_across_lines - a number with the maximum value for highest_wf_words attribute in the analyzers array.
  def highest_count_across_lines
    @highest_count_across_lines
  end

  #* highest_count_words_across_lines - a filtered array of LineAnalyzer objects with the highest_wf_words attribute
  #  equal to the highest_count_across_lines determined previously.
  def highest_count_words_across_lines
    @highest_count_words_across_lines
  end

  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  # Implement the following methods in the Solution class.
  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers.
  #* calculate_line_with_highest_frequency() - determines the highest_count_across_lines and 
  #  highest_count_words_across_lines attribute values
  #* print_highest_word_frequency_across_lines() - prints the values of LineAnalyzer objects in 
  #  highest_count_words_across_lines in the specified format
  
  # Implement the analyze_file() method() to:
  #* Read the 'test.txt' file in lines 
  #* Create an array of LineAnalyzers for each line in the file

  def initialize ()
    @analyzers = Array.new
    #p @analyzers.length
  end

  def analyze_file()
    count = 0
    #p @analyzers.length
    File.foreach( 'test.txt') do |line|
      newAnalyzer = LineAnalyzer.new(line, count)
      @analyzers << newAnalyzer
      count += 1
    end
  end


  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
  #  and stores this result in the highest_count_across_lines attribute.
  #* identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines 
  #  attribute value determined previously and stores them in highest_count_words_across_lines.

  def calculate_line_with_highest_frequency()
    current_highest_wf_count = 0
    @highest_count_words_across_lines = []

    @analyzers.each do |lineAnalyzer|
      if current_highest_wf_count <= lineAnalyzer.highest_wf_count
        current_highest_wf_count = lineAnalyzer.highest_wf_count
      end
    end

    @highest_count_across_lines = current_highest_wf_count

    @analyzers.each do |lineAnalyzer|
      if lineAnalyzer.highest_wf_count == current_highest_wf_count
        @highest_count_words_across_lines << lineAnalyzer
      end
    end

  end

  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the values of objects in highest_count_words_across_lines in the specified format

  def print_highest_word_frequency_across_lines()
    @highest_count_words_across_lines.each do |filteredLine|
      p "#{filteredLine.highest_wf_words} (appears in line #{filteredLine.line_number})"
    end
  end

end

