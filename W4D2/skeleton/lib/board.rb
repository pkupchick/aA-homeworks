require_relative "./player.rb"
require "byebug"
class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @player_1 = Player.new(name1, 1)
    @player_2 = Player.new(name1, 2)
    @cups = Array.new(14) { [] }
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    4.times do
      (0..13).each do |i|
        unless i == 6 || i == 13
          @cups[i] << :stone
        end
      end
    end
    @cups
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if start_pos < 0 || start_pos > 12
    raise "Starting cup is empty" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos]
    @cups[start_pos] = []

    start_idx = start_pos
    until stones.empty? 
      (start_idx += 1) % 14
      if start_idx == 6
        @cups[6] << stones.shift if current_player_name == @player_1.name
      elsif start_idx == 13
        @cups[13] << stones.shift if current_player_name == @player_2.name
      else
        @cups[start_idx] << stones.shift
      end
    end
    next_turn(start_idx)
  end

  def next_turn(ending_cup_idx)
    # debugger
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if @cups[ending_cup_idx] == []
      :switch
    elsif ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    (0..5).all? { |idx| @cups[idx].empty? } || (7..12).all? { |idx| @cups[idx].empty? }
  end

  def winner
  end
end

# test = Board.new(:john, :sam)

# p test.place_stones

# p test.cups