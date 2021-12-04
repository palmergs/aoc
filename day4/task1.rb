input = File.read('input.txt').split(/[\n\r]/)
numbers = input[0].split(',')

class Board
  Square = Struct.new(:num, :match) do
    def to_s
      "#{ num }#{ match ? '*' : '' }"
    end
  end

  attr_reader :index, :board

  def initialize index, input
    @index = index / 6
    @board = []
    (0..4).each do |n| 
      row = input[index + n].strip.split(/\s+/).compact.map {|n| Square.new(n.to_i, false) }
      @board += row
    end
  end

  def match? n
    @board.each do |sq|
      if sq.num == n.to_i
        sq.match = true
        return true
      end
    end

    false
  end

  def unmatched
    board.select {|sq| sq.match == false}.map {|sq| sq.num }
  end

  def score number
    unmatched.inject(&:+) * number.to_i
  end

  def win?
    (0..4).each do |r|
      return true if row?(r)
    end

    (0..4).each do |c|
      return true if col?(c)
    end

    false
  end

  def row? r
    (0..4).each do |c|
      return false if board[Board.from_rc(r, c)].match == false
    end

    true
  end

  def col? c
    (0..4).each do |r|
      return false if board[Board.from_rc(r, c)].match == false
    end

    true
  end

  def to_s
    "#{ index }: #{ board.join(', ') }"
  end

  def self.from_xy x, y
    y * 5 + x
  end

  def self.from_rc row, col
    row * 5 + col
  end

  def self.to_xy idx
    [idx % 5, idx / 5]
  end
end

boards = []
index = 2
while index < input.length
  boards << Board.new(index, input)
  index += 6
end

numbers.each do |n|
  puts "calling #{ n }"
  boards.each do |board|
    if board.match?(n)
      puts "match: #{ board }"
      if board.win?
        raise "board: #{ board.index } input: #{ n } score: #{ board.score(n) }"
      end
    end
  end
end
