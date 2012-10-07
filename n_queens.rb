class NQueens

  def initialize
    @count=0
  end

  def find_n_queens(board,col)
    already_visited = board.select{|cell| board[col][cell] == "X"}.keys[0]
    if !already_visited.nil?
      board[col][already_visited] = "-"
    end
    possible = possible_position(board,col)
    if possible > 0
      board[col][possible] = "X"
      if col + 1 <= 8
        find_n_queens(board,col + 1)
      else
        @count=@count+1
        board.values.each{|c| puts c.values.join(' ')}
        puts
        [1,2,3,4,5,6,7,8].each{|row| board[col][row]="."}
        find_n_queens(board,col - 1)
      end
    elsif col-1 > 0
      [1,2,3,4,5,6,7,8].each{|row| board[col][row]="."}
      find_n_queens(board,col - 1)
    end
    @count
  end

  def possible_position(board,col)
    queens_in_prev_cols = board.entries.select{|entry| entry[1].values.include? "X"}.map{|entry| [entry[0],entry[1].select{|cell| entry[1][cell] == "X"}.keys[0]]}
    free_positions = board[col].select{|cell| board[col][cell] != "-"}.map{|free|[col,free[0]]}
    if free_positions.nil? or free_positions.empty?
      return 0
    end
    if queens_in_prev_cols.empty?
      return free_positions[0][1]
    else
      possible_pos = free_positions.select{|n| queens_in_prev_cols.select{|l| (l[0]-n[0] == 0 or l[1]-n[1]==0 or ((l[0]-n[0]).abs==(l[1]-n[1]).abs))}.empty?}
    end
    if possible_pos.empty?
      return 0
    else
      return possible_pos[0][1]
    end	
  end
end


a = {}
[1,2,3,4,5,6,7,8].each{|c| a[c] = {1=>".", 2=>".", 3=>".", 4=>".", 5=>".", 6=>".", 7=>".", 8=>"."}}
puts NQueens.new.find_n_queens(a,1)
