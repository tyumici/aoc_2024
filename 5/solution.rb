$page_order = []
$updates = []
$part_correct_order = 0
$part_incorrect_order = 0
$incorrect_updates = []
$part_two = 0

def cleanData
  text = File.readlines('/home/human/Documents/GIT/aoc_2024/5/input.txt').map(&:chomp)
  mid = text.index("")
  p = text[0...mid]
  u = text[(mid + 1)..-1]
  $page_order = p.map {|page| page.split("|").map(&:to_i)}
  $updates = u.map {|update| update.split(",").map(&:to_i)}
  whosOnFirst()
end

def whosOnFirst()
  $updates.each_with_index do |update, index_u|
    $page_order.each_with_index do |page, index_p|
      mid = update[update.length / 2]
      if update.include?(page[0]) && update.include?(page[1])
        first = update.index(page[0])
        last = update.index(page[1])
        if first < last
          #puts "#{update} #{page[0]} is before #{page[1]}"
          if index_p == $page_order.length - 1
            $part_correct_order += mid
            # puts "added #{mid}, now at #{$part_correct_order}"
          end
        else
          #   puts 'invalid'
          #   puts "#{update} #{page[0]} is NOT before #{page[1]}"
          $incorrect_updates.push(update)
          break
        end
      else
        if index_p == $page_order.length - 1
          $part_correct_order += mid
          #   puts "added #{mid}, now at #{$part_correct_order}"
        end
      end
    end
  end
  puts "part one value #{$part_correct_order}"
  #puts "invalid one #{$incorrect_updates}"
  mistakesCorrected()
end

def mistakesCorrected()
  $incorrect_updates.each_with_index do |update, index_u|
    $page_order.each_with_index do |page, index_p|
      if update.include?(page[0]) && update.include?(page[1])
        first = update.index(page[0])
        last = update.index(page[1])
        if first > last
          update.delete_at(first)
          update.unshift(page[0])
          $incorrect_updates[index_u] = update
          puts "#{page} #{update}"
          mid = update[update.length / 2]
          if index_p == $page_order.length - 1
            $part_two += mid
            # puts "added #{mid}, now at #{$part_correct_order}"
          end
        else
          if index_p == $page_order.length - 1
            mid = update[update.length / 2]
            
            $part_two += mid
            # puts "added #{mid}, now at #{$part_correct_order}"
          end
        end
      end
    end
  end
  $incorrect_updates.each do |update|
    mid = update[update.length / 2]
    $part_two += mid
  end
  puts $part_two
end

##| live_loop :sync_cue do
##|   cue :start
##|   sleep 0.2
##| end
cleanData()
