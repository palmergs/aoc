input = File.read('input.txt').split(',').map(&:to_i)

DAYS = 256
fishes = Array.new(DAYS) { 0 }
fishes[0] = input.count

births = Array.new(DAYS) { 0 }
input.each do |input|
  n = input
  while n < DAYS
    births[n] += 1
    n += 7
  end
end

DAYS.times do |n|
  day = n
  count = births[day]
  puts "day=#{ n } count=#{ count }"
  day += 9
  while day < DAYS
    births[day] += count
    day += 7
  end
end

puts "births=#{ births.join(',') }"

#while timer = input.pop
#  next if timer >= DAYS
#
#  birth = timer
#  while birth < DAYS
#    fishes[birth] += 1
#    input.push(birth + 9)
#    birth += 7
#  end
#
#  puts "timer=#{ timer } size=#{ input.size }"
#end

puts "sum=#{ 300 + births.inject(&:+) }"
