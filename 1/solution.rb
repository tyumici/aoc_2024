input = IO.read('/home/human/Documents/GIT/aoc_2024/1/input.txt').lines.map(&:chomp)

def formatInput(input)
    column1 = []
    column2 = []

    input.each do |val|
        column_values = val.split(/\s+/)

        column1 << column_values[0].to_i
        column2 << column_values[1].to_i
    end

    column1 = column1.sort
    column2 = column2.sort

    return [column1, column2]
end

columns = formatInput(input)
puts columns[0]
puts columns[1]

def part1(input)
    dist = 0

    input[0].each_with_index do |col, index|
        diff = (col - input[1][index]).abs
        dist += diff
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
