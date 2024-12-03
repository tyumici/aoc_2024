input = IO.read('/home/human/Documents/GIT/aoc_2024/2/input.txt').lines.map(&:chomp)
$part_one_array = []
$safe_count = 0

def formatInput(input)
  input.each do |val|
    report = val.split(/\s+/).map(&:to_i)
    $part_one_array.push(report)
  end
  part1($part_one_array)
end

def safeCheck(input)
  increase = (0...input.length - 1).all? { |i| input[i] < input[i + 1] }
  decrease = (0...input.length - 1).all? { |i| input[i] > input[i + 1] }
  withinThree = (0...input.length - 1).all? {
    |i| (input[i] - input[i + 1]).abs >= 1 &&  (input[i] - input[i + 1]).abs <= 3
  }
  note3 = input.first(3)
  
  if decrease
    use_synth :growl
    sleep 0.2
    play note3, sustain: 0.75
  elsif increase
    samp = input.sample
    sleep 0.2
    use_synth :gabberkick
    play samp
    use_synth :dpulse
    play samp, pan: 1
    sleep 0.1
    play samp, pan: -1
  end
  
  if (increase && decrease) && !withinThree
    use_synth :pulse
    play input
  end
  
  return (increase || decrease) && withinThree
end

def part1(p1Arr) # 559
  p1Arr.each do |v|
    safe = safeCheck(v)
    if safe
      $safe_count += 1
      use_synth :gabberkick
      play v[3]
      sleep 0.1
    else
      (0...v.length).each do |i|
        modified_array = v[0...i] + v[(i + 1)..-1]
        resafe = safeCheck(modified_array)
        if resafe
          $safe_count += 1
          use_synth :blade
          play v.first(2), release: 3, sustain: 2
          break
        end
      end
    end
    
  end
  puts $safe_count
end


formatInput(input)
