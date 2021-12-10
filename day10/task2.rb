lines = File.read('input.txt').split(/[\n\r]/)
delims = { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }
scoring = { ')' => 3, ']' => 57, '}' => 1197, '>' => 25137 }
autocomp = { '(' => 1, '[' => 2, '{' => 3, '<' => 4 }
corrupt = {}
incomp = []
Corrupt = Struct.new(:char, :index)
lines.each_with_index do |line, idx|
  stack = []
  # puts "line=#{ line }"
  skip = false
  line.chars.each_with_index do |c, n|
    if delims.key?(c)
      stack.push(c)
    else
      d = stack.pop
      if delims[d] != c
        corrupt[idx] = Corrupt.new(c, n)
        skip = true
        break
      end
    end
  end
 
  unless skip
    sum = 0
    stack.reverse.each do |c|
      sum *= 5
      sum += autocomp[c]
      puts "stack=#{ stack } sum=#{ sum }"
    end
    incomp << sum
  end
end

puts corrupt.inspect
puts "corrupt = #{ corrupt.size }"
score = 0
corrupt.each do |line_num, c|
  score += scoring[c.char]
end
puts "score = #{ score }"

puts "incomplete = #{ incomp.size }"
# puts incomp.sort
score = incomp.sort[incomp.length / 2]

# between
# 1061215331
# 1139561161
puts "score = #{ score }"
