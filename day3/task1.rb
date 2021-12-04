entries = File.read('input.txt').split
arr = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]]
entries.each do |entry|
  entry.split('').each_with_index do |ch, idx|
    arr[idx][ch.to_i] += 1
  end
end

gamma = ''
epsilon = ''
arr.each do |col|
  puts "0: #{ col[0] } 1: #{ col[1] } => #{ col[0] > col[1] ? 0 : 1 }"
  gamma << (col[0] > col[1] ? '0' : '1')
  epsilon << (col[0] > col[1] ? '1' : '0')
end

def to_num bin
  bin.reverse.chars.map.with_index {|d, i| d.to_i * 2**i}.sum
end

puts "gamma: 0b#{ gamma } (#{ to_num(gamma) })"
puts "epsilon: 0b#{ epsilon } (#{ to_num(epsilon) })"
puts "diagnostic: #{ to_num(gamma) * to_num(epsilon) }"

