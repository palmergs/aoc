require 'set'

lines = File.read('input.txt').split(/[\n\r]/)

# 0 = 6 lines
# 1 = 2 lines *
# 2 = 5 lines
# 3 = 5 lines
# 4 = 4 lines *
# 5 = 5 lines
# 6 = 6 lines
# 7 = 3 lines *
# 8 = 7 lines *
# 9 = 6 lines

class Entry
  LEN_TO_VAL = { 2 => 1, 4 => 4, 3 => 7, 7 => 9 }.freeze

  STR_TO_VAL = {
    'abcefg' => 0,
    'cf' => 1,
    'acdeg' => 2,
    'acdfg' => 3,
    'bcdf' => 4,
    'abdfg' => 5,
    'abdefg' => 6,
    'acf' => 7,
    'abcdefg' => 8,
    'abcdfg' => 9,
  }.freeze

  attr_reader :inputs, :outputs

  def initialize line
    inputs, outputs = line.split(' | ')
    @inputs = inputs.split(' ').sort {|a, b| a.length <=> b.length }.map {|str| str.chars.to_set }
    @outputs = outputs.split(' ')
  end

  def map
    @map ||= build_map
  end 

  def translate
    outputs.inject([]) do |arr, output|
      arr << output.chars.map {|c| map[c] }.sort.join
      arr
    end.map do |str| 
      STR_TO_VAL[str]
    end.inject(0) do |num, val|
      num *= 10
      num += val
      num
    end
  end
  
  def build_map
    ones = inputs[0]
    fours = inputs[2]
    eights = inputs[9]
    sevens = inputs[1]

    # we can determine the top segment from 7
    top = (sevens - ones)

    # we can determine the bottom segment by subtracting 
    # 4 and top from 9
    nines = nil
    bottom = nil
    inputs.each do |input|
      if input.size == 6 && (input & fours == fours)
        nines = input
        bottom = (nines - fours - top)
      end
    end

    # lower left is easy
    lower_left = (eights - nines)

    # we can determine the middle segment by subtracting
    # 7 and bottom from 3
    threes = nil
    twos = nil
    fives = nil
    middle = nil
    inputs.each do |input|
      if input.size == 5 && (input & sevens == sevens)
        threes = input
        middle = (threes - sevens - bottom)
      elsif input.size == 5 && (lower_left - input).empty?
        twos = input
      elsif input.size == 5 && !(lower_left - input).empty?
        fives = input
      end
    end

    # upper left is 4 minus 1 and middle
    upper_left = (fours - ones - middle)

    # zeros do not hava middle bar; sixes do but 
    zeros = nil
    sixes = nil
    upper_right = nil
    inputs.each do |input|
      if input.size == 6 && (input - middle) == input
        zeros = input
      elsif input.size == 6 && !(sevens - input).empty?
        sixes = input
        upper_right = (ones - sixes)
      elsif input.size == 6 && (sevens - input).empty?
        # NOOP already have nines
      end
    end

    lower_right = (eights - twos - upper_left)

    #puts "top = #{ top }"
    #puts "middle = #{ middle }"
    #puts "bottom = #{ bottom }"
    #puts "upper left = #{ upper_left }"
    #puts "upper right = #{ upper_right }"
    #puts "bottom left = #{ lower_left }"
    #puts "bottom right = #{ lower_right }"
    {
      top.to_a.first => 'a',
      upper_left.to_a.first => 'b',
      upper_right.to_a.first => 'c',
      middle.to_a.first => 'd',
      lower_left.to_a.first => 'e',
      lower_right.to_a.first => 'f',
      bottom.to_a.first => 'g',
    }
  end
 
  def self.length_to_val str
    LEN_TO_VAL[str.length]
  end

  def self.str_to_val str
    STR_TO_VAL[str]
  end
end

entries = lines.map do |line| 
  Entry.new(line)
end

sum = 0
entries.each do |entry|
  sum += entry.translate
end
puts "sum=#{ sum }"
