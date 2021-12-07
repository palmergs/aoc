input = File.read('input.txt').split(',').map(&:to_i)
input.sort!
num = input.length
avg = input.inject(&:+) / input.length
med = num % 2 == 0 ? (input[num/2] + input[num/2 + 1]) / 2 : input[num/2]

calc = ->(n1, n2) {
  diff = (n1 - n2).abs
  sum = 0
  diff.times {|d| sum += (1 + d)}
  sum
}

dist = ->(num) {
  input.map {|n| calc.call(n, num) }.inject(&:+)
}


puts "zer = #{ 0 } (#{ dist.call(0) })"
puts "num = #{ num } (#{ dist.call(num) })"
puts "avg = #{ avg } (#{ dist.call(avg) })"
puts "med = #{ med } (#{ dist.call(med) })"
