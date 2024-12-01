input = IO.read('/home/human/Documents/GIT/aoc_2024/1/input.txt').lines.map(&:chomp)
$output_part_1 = '/home/human/Documents/GIT/aoc_2024/1/output_part_1.txt'

$part1_playhead_note = []
$output_part_1_array = []
$max = 127

use_synth :bass_foundation

def formatInput(input)
  column1 = [] # left
  column2 = [] # right
  
  input.each do |val|
    # store each side in a single array, as ints
    column_values = val.split(/\s+/)
    
    column1 << column_values[0].to_i
    column2 << column_values[1].to_i
  end
  
  # sort both small to large
  column1 = column1.sort
  column2 = column2.sort
  
  return [column1, column2]
end

# run format
columns = formatInput(input)

def part1(input)
  dist = 0
  
  input[0].each_with_index do |col, index|
    diff = (col - input[1][index]).abs
    dist += diff
    $output_part_1_array.push(diff)
    # write diffs out as txt file
    if $output_part_1_array.length == 1000
      min_value = $output_part_1_array.min
      max_value = $output_part_1_array.max
      normalized_values = $output_part_1_array.map do |value|
        ((value - min_value).to_f / (max_value - min_value)) * $max
      end
      $output_part_1_array = normalized_values
      $output_part_1_array.map do |note|
        play note, release: 0.46
        sleep 0.25
      end
      ##| File.open($output_part_1, "w") do |file|
      ##|   normalized_values.each do |number|
      ##|     file.puts number.to_i
      ##|   end
      ##| end
    end
  end
  return dist
end

def part2(input)
  simScore = 0
  input[0].each_with_index do |col, index|
    count = input[1].count(col)
    simScore += count * col
  end
  return simScore
end

puts part1(columns) # 1590491
puts part2(columns) # 22588371