input = File.read('input.txt').split(',').map(&:to_i)
input.sort!
num = input.length
avg = input.inject(&:+) / input.length
med = num % 2 == 0 ? (input[num/2] + input[num/2 + 1]) / 2 : input[num/2]

dist = ->(num) {
  input.map {|n| (num - n).abs }.inject(&:+)
}


puts "num = #{ num } (#{ dist.call(num) })"
puts "avg = #{ avg } (#{ dist.call(avg) })"
puts "med = #{ med } (#{ dist.call(med) })"
