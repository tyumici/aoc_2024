$input_clean = File.readlines('/home/human/Documents/GIT/aoc_2024/4/input.txt').map(&:chomp).map(&:chars)
$word = "XMAS"
$mass_x = "MAS"
$directions = [
  [0, -1],  # left
  [0, 1],   # right
  [1, 0],   # down
  [1, -1],   # up-right
  [1, 1],   # down-right
  [-1, 1],  # down-left
  [-1, -1], # up-left
  [-1, 0],  # up
]
$delta_row = [-1, 0, 1]
$delta_col = [-1, 0, 1]
$part_one = 0
$part_two = 0

def find_word(grid, start_row, start_col, direction)

  (0...$word.length).each do |i|
    new_row = start_row + i * direction[0]
    new_col = start_col + i * direction[1]
    return false if new_row < 0 || new_row >= grid.length || new_col < 0 || new_col >= grid[0].length
    return false if grid[new_row][new_col] != $word[i]
  end

  true
end

def part1(input)
  (0...input.length).each do |row|
    (0...input[0].length).each do |col|
      $directions.each do |dir|
        if find_word(input, row, col, dir)
          $part_one += 1
        end
      end
    end
  end
  puts $part_one
end

def check_inbound(row, col)
  row.between?(0, $input_clean.length - 1) && col.between?(0, $input_clean[0].length - 1)
end

def check_at(row, col)
  check_inbound(row, col) ? $input_clean[row][col] : nil
end

def part2(input)
  (0...input.length).each do |row|
    (0...input[0].length).each do |col|
      if check_at(row, col) == 'A'
        diag1 = (-1..1).map { |i| check_at(row + i, col + i) }.join
        diag2 = (-1..1).map { |i| check_at(row + i, col - i) }.join
  
        $part_two += 1 if (diag1 == $mass_x || diag1.reverse == $mass_x) && (diag2 == $mass_x || diag2.reverse == $mass_x)
      end
    end
  end
  puts $part_two
end

part1($input_clean) # 2401
part2($input_clean) # 1882