### LEAD BUFFER

input = IO.read('/home/human/Documents/GIT/aoc_2024/3/input.txt')

$combo_reggie = Regexp.new(/(\bdon't\(\))|(\bdo\(\))|(\bmul\(\s*\d+,\d+\))/)
$clean_valids = []

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
  $clean_valids = input.dup
end

getValid(input)

live_loop :sync_cue do
  cue :start
  sleep 0.2
end

### PART 1 BUFFER

def playHead(input)
  sleep 0.2
  ding = input[0] + input[1]
  dong = ding.to_s.slice(0,2)
  return dong.to_i
end

def part1 ()
  part_one_sum = 0
  matches = $clean_valids
  live_loop :buffer1 do
    sync :start
    matches.each do |mul|
      if mul.is_a?(Array)
        use_synth :blade
        play playHead(mul)
        mult = mul[0] * mul[1]
        part_one_sum += mult
        if (mult % 7) === 0
          use_synth :dtri
          play playHead(mul), sustain: 1, amp: 0.6, attack: 1
        end
      end
    end
  end
  puts part_one_sum
end

part1()
  
### PART 2 BUFFER

$last = 0
def playHead(input)
  sleep 0.2
  ding = (input[0] - input[1]).abs + 20
  dong = ding.to_s.slice(0,2)
  $last = dong.to_i
  return dong.to_i
end

def part2()
  part_two_sum = 0
  doing = true
  valids = $clean_valids
  live_loop :buffer2 do
    sync :start
    valids.each do |v|
      if v.is_a?(Array)
        if doing
          mult = v[0] * v[1]
          part_two_sum += mult
          if (mult % 4) === 0
            use_synth :sc808_congahi
            play playHead(v)
          end
        end
      else
        use_synth :sc808_bassdrum
        with_fx :reverb do
          play $last, pan: 1
          sleep 0.1
          play $last, pan: -1
        end
        doing = v
      end
    end
  end
  puts part_two_sum
end

part2()