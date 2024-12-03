input = IO.read('/home/human/Documents/GIT/aoc_2024/3/input.txt')

$combo_reggie = Regexp.new(/(\bdon't\(\))|(\bdo\(\))|(\bmul\(\s*\d+,\d+\))/)
$part_one_sum = 0
$part_two_sum = 0

def getValid(input)
  puts input
  cleaned_input = []
  valids =  input.scan($combo_reggie)
  valids.each do |v|
    cleaned_input.push(v.compact[0])
  end
  cleanValids(cleaned_input)
end

def cleanValids(input)
  puts input
  input.each_with_index do |mul,index|
    if mul.include?('mul')
      vals = mul.split(',')
      pair = [vals[0].match($number_regex)[0].to_i, vals[1].match($number_regex)[0].to_i]
      input[index] = pair
    elsif mul === "don't()"
      input[index] = false
    else
      input[index] = true
    end
  end
  return input
end

def part1 (input)
  matches = getValid(input)
  matches.each do |mul|
    if mul.is_a?(Array)
      mult = mul[0] * mul[1]
      $part_one_sum += mult
    end
  end
  puts $part_one_sum
end

def part2(input)
  doing = true
  valids = getValid(input)
  valids.each do |v|
    if v.is_a?(Array)
      if doing
        mult = v[0] * v[1]
        $part_two_sum += mult
      end
    else
      doing = v
    end
  end
  puts $part_two_sum
end

part1(input) # 173731097
part2(input) # 93729253