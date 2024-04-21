$position_typed = true

class TicTacToe
  @@symbol
  @@board_arr = [".", ".", ".", ".", ".", ".", ".", ".", "."]
  @@positions = ["tl", "tm", "tr",
    "ml", "mm", "mr",
    "bl", "bm", "br"
   ]
  @@positions_played = []
  @@computer_turn_arr = ["tl", "tm", "tr",
  "ml", "mm", "mr",
  "bl", "bm", "br"]

  def initialize
    @player_won = false
    @computer_won = false
    @tied_game = false
  end

  attr_accessor :player_won, :computer_won, :tied_game

  def player_turn(position)
    @position = position.downcase
    @@symbol = "X"

    get_board(@position, @@symbol)

    if $position_typed != false && @@board_arr.include?(".") == true
      return computer_turn
    end

    if @@board_arr.include?(".") == true
      return
    elsif @player_won
      return "#{@new_string} \n You won!"
    else
      @tied_game = true
      return "#{@new_string} \n Tie game."
    end
  end

  def computer_turn
    @@symbol = "O"
    random_position = get_positions.sample

    while @@positions_played.include?(random_position)
      random_position = get_positions.sample
    end

    get_board(random_position, @@symbol)

  end

  def get_positions
    @@positions
  end

  def get_board_arr
    @@board_arr
  end

  def get_board(position, symbol)
    if @@positions_played.include?(position)
      return "Position already chosen, choose another!"
    end

    index = @@positions.index(position)

    begin
      @@board_arr[index] = symbol
    rescue TypeError => e
      puts "Please enter a position"
      return $position_typed = false
    end

    $position_typed = true
    board_string = @@board_arr.join
    @@positions_played.push(position)

    check_if_won

    @new_string = ""

    board_string.each_char.with_index do |c, i|
      @new_string += c
      @new_string += "\n" if (i + 1) % 3 == 0
    end

    if @player_won
      return "#{@new_string} \n You won!"
    elsif @computer_won
      return "#{@new_string} \n You lost :("
    elsif @tied_game
      return "#{@new_string} \n Tie! Refresh board to keep playing!"
    else
      @new_string
    end
  end

  def check_if_won
  check_array = @@board_arr

  return @player_won = true if check_array.at(0) == "X" && check_array.at(1) == "X" && check_array.at(2) == "X"
  return @player_won = true if check_array.at(0) == "X" && check_array.at(4) == "X" && check_array.at(8) == "X"
  return @player_won = true if check_array.at(0) == "X" && check_array.at(3) == "X" && check_array.at(6) == "X"
  return @player_won = true if check_array.at(3) == "X" && check_array.at(4) == "X" && check_array.at(5) == "X"
  return @player_won = true if check_array.at(6) == "X" && check_array.at(7) == "X" && check_array.at(8) == "X"
  return @player_won = true if check_array.at(1) == "X" && check_array.at(4) == "X" && check_array.at(7) == "X"
  return @player_won = true if check_array.at(2) == "X" && check_array.at(5) == "X" && check_array.at(8) == "X"
  return @player_won = true if check_array.at(2) == "X" && check_array.at(4) == "X" && check_array.at(6) == "X"

  return @computer_won = true if check_array.at(0) == "O" && check_array.at(1) == "O" && check_array.at(2) == "O"
  return @computer_won = true if check_array.at(0) == "O" && check_array.at(4) == "O" && check_array.at(8) == "O"
  return @computer_won = true if check_array.at(0) == "O" && check_array.at(3) == "O" && check_array.at(6) == "O"
  return @computer_won = true if check_array.at(3) == "O" && check_array.at(4) == "O" && check_array.at(5) == "O"
  return @computer_won = true if check_array.at(6) == "O" && check_array.at(7) == "O" && check_array.at(8) == "O"
  return @computer_won = true if check_array.at(1) == "O" && check_array.at(4) == "O" && check_array.at(7) == "O"
  return @computer_won = true if check_array.at(2) == "O" && check_array.at(5) == "O" && check_array.at(8) == "O"
  return @computer_won = true if check_array.at(2) == "O" && check_array.at(4) == "O" && check_array.at(6) == "O"

  return @tied_game = true if check_array.include?(".") == false && @player_won = false && @computer_won = false
  end
end

new_game = TicTacToe.new

puts "Please enter your choice, board is: \n tl, tm, tr \n ml, mm, mr, \n bl, bm, br"

while new_game.player_won == false && new_game.computer_won == false && new_game.tied_game == false
  puts "Please enter your choice: "
  choice = gets.chomp
  puts new_game.player_turn(choice)
  p new_game.get_board_arr
end
