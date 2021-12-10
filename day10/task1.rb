lines = File.read('input.txt').split(/[\n\r]/)
delims = { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }
scoring = { ')' => 3, ']' => 57, '}' => 1197, '>' => 25137 }
corrupt = {}
Corrupt = Struct.new(:char, :index)
lines.each_with_index do |line, idx|
  stack = []
  puts "line=#{ line }"
  line.chars.each_with_index do |c, n|
    if delims.key?(c)
      puts "push #{ c }"
      stack.push(c)
    else
      d = stack.pop
      puts "pop #{ d }"
      if delims[d] != c
        puts "corrupt @ #{ n }"
        corrupt[idx] = Corrupt.new(c, n)
        break
      end
    end
  end
end

puts corrupt.inspect
puts "corrupt = #{ corrupt.size }"
score = 0
corrupt.each do |line_num, c|
  score += scoring[c.char]
end
puts "score = #{ score }"


