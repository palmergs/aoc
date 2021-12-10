require 'set' 

lines = File.read('input.txt').split(/[\n\r]/)
array = lines.map {|str| str.chars.map(&:to_i) }

class Heights
  NEIGHBORS = [
    [-1, 0],
    [ 0, 1],
    [ 1, 0],
    [ 0,-1],
  ].freeze

  attr_reader :array, :width, :height

  def initialize array
    @array = array
    @width = @array[0].length
    @height = @array.length
  end

  def at x, y
    return nil if x < 0
    return nil if y < 0
    return nil if x >= width
    return nil if y >= height

    row = array[y]
    row[x]
  end

  def neighbors x, y, exclude = Set.new
    NEIGHBORS.inject(Set.new) do |set, pair|
      nx = pair[0] + x
      ny = pair[1] + y
      next set if nx < 0 || nx >= width
      next set if ny < 0 || ny >= height
      next set if exclude.include?([nx, ny])

      set << [nx, ny]
      set
    end
  end

  def values set
    set.inject([]) do |arr, pair|
      arr << at(pair[0], pair[1])
      arr
    end
  end

  def lowest? x, y
    curr = at(x, y)
    return false if curr == 9

    set = neighbors(x, y)
    vals = values(set)
    vals.all? do |n| 
      n > curr
    end
  end

  def lowest
    arr = []
    array.each_with_index do |row, y|
      row.each_with_index do |val, x|
        arr << val + 1 if lowest?(x,y)
      end
    end
    arr
  end

  def sum
    lowest.inject(&:+)
  end

  def basins 
    basins = []
    (0...width).each do |x|
      (0...height).each do |y|
        basins << build_basin(x, y) if lowest?(x, y)
      end
    end
    basins
  end

  def build_basin x, y  
    basin = Set.new
    basin << [x, y]
    candidates = [[x, y]]
    while !candidates.empty?
      x, y = candidates.pop
      curr = at(x, y)
      neighbors(x, y, basin).each do |x, y|
        if at(x, y) < 9
          basin << [x, y]
          candidates << [x, y]
        end
      end
    end

    basin
  end
end

h = Heights.new(array)
arr = h.basins
arr = arr.map(&:size).sort.last(3)
puts "arr=#{ arr } = #{ arr[0] * arr[1] * arr[2] }"
