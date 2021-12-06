fishes = File.read('input.txt').split(',').map(&:to_i)
last = 0
timer = Time.now
80.times do |n|
  tmp = []
  fishes.count.times do |idx|
    if fishes[idx] == 0
      tmp << 8
      fishes[idx] = 6
    else
      fishes[idx] -= 1
    end
  end
  fishes += tmp
  puts "after #{ n + 1 }. #{ fishes.count } (+#{ fishes.count - last } in #{ Time.now - timer })"
  last = fishes.count
  timer = Time.now
end

puts "fishes: #{ fishes.count }"
