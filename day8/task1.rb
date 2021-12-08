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
  LEN_TO_VAL = { 2 => 1, 4 => 4, 3 => 7, 7 => 9 }
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
  }

  attr_reader :inputs, :outputs, :map
  def initialize line
    @inputs, @outputs = line.split(' | ')
    @inputs = @inputs.split(' ')
    @outputs = @outputs.split(' ')
    @map = build_map
  end
  
  def to_s
    [
      "#{ inputs.join(' ') } | #{ outputs.join(' ') }",
      "#{ inputs.map {|s| input_to_output(s) }.join(' ') } | #{ outputs.map {|s| input_to_output(s) }.join(' ') }",
    ].join("\n")
  end

  def build_map
    m = {}
    inputs.each do |s|
      build_known_map(m, s)
    end
    m
  end
  
  def build_known_map map, str
    case str.length
    when 2
      map[str[0]] = 'c'
      map[str[1]] = 'f'
    when 4
      map[str[0]] = 'b'
      map[str[1]] = 'c'
      map[str[2]] = 'd'
      map[str[3]] = 'f'
    when 3
      map[str[0]] = 'a'
      map[str[1]] = 'c'
      map[str[2]] = 'f'
    when 7
      map[str[0]] = 'a'
      map[str[1]] = 'b'
      map[str[2]] = 'c'
      map[str[3]] = 'd'
      map[str[4]] = 'e'
      map[str[5]] = 'f'
      map[str[6]] = 'g'
    end
    puts "after #{ str } map = #{ map }"
  end
  
  def input_to_output str
    out = []
    str.chars.each do |c|
      out << map[c]
    end
    out.sort.join
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
  raise 'stop'
end

values = []
entries.each do |entry|
  arr = entry.outputs.map {|s| Entry.length_to_val(s) }
  # puts "#{ entry.outputs.join(' ') } => #{ arr.join(',') }"
  values += arr.compact
end
puts values.count


e = entries.first
puts e
puts e.map
