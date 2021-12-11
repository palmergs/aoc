require 'set'

class Octopi

  attr_reader :array, :flashes

  def initialize path
    @array = File.read(path).split(/[\n\r]/).map {|row| row.chars.map(&:to_i) }
    @flashes = 0
  end

  def step
    exploding = increment
    # exploded = Set.new

    while !exploding.empty?
      puts "number to explode = #{ exploding.size }"
      # puts "number exploded = #{ exploded.size }"
      ex = exploding.pop
      puts "exploding #{ ex }"
      # exploded << ex
      explode(ex[0], ex[1], exploding)
    end

    reset
    display_map
  end

  def reset
    (0...10).each do |row|
      (0...10).each do |col|
        if array[row][col] > 9
          array[row][col] = 0
          @flashes += 1
        end
      end
    end
  end

  def increment
    exploding = []
    (0...10).each do |row|
      (0...10).each do |col|
        array[row][col] += 1
        exploding << [row,col] if array[row][col] == 10
      end
    end
    exploding
  end

  def explode row, col, exploding
    (-1..1).each do |dr|
      (-1..1).each do |dc|
        next if dr == 0 && dc == 0

        nr = row + dr
        next if nr < 0 || nr >= 10

        nc = col + dc
        next if nc < 0 || nc >= 10

        array[nr][nc] += 1
        if array[nr][nc] == 10
          exploding << [nr,nc]
        end
      end
    end
  end

  def display_map 
    (0...10).each do |row|
      (0...10).each do |col|
        if array[row][col] > 9
          print '*'
        else
          print "#{ array[row][col] }"
        end
      end
      print "\n"
    end
    puts "flashes = #{ flashes }"
    print "\n"
  end

end

o = Octopi.new('input.txt')
#o.step
#o.step
100.times { o.step }
