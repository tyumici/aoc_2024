import * as fs from 'fs';

let length = 0
let height = 0
let nodes = new Map<string,number[][]>()
let antiNodes = new Set<string>()
const input = fs.readFileSync('/home/human/Documents/GIT/aoc_2024/8/sample.txt', 'utf-8')
    .split('\n');
length = input[0].length
height = input.length
console.log(`length: ${length}, height ${height}`)
console.log(input)

function parseLine(line: string, currRow: number) {
    let chars = [...line]
    chars.forEach((char,index) => {
        if (char !== '.') {
            if (nodes.has(char)) {
                let tower = nodes.get(char) ?? []
                tower.push([index, currRow])
                nodes.set(char, tower)
            } else {
                nodes.set(char, [[index, currRow]])
            }
        }
    });
}

function rangeCheck(pos: number[]): boolean {
    return pos[0] >= 0 || pos[1] >= 0 || pos[0] <= length || pos[1] <= height
}

function part1() {
    input.forEach((line, index) => {
        parseLine(line, index)
    })
    nodes.forEach((val, key) => {
        const start = val[0]
        val.splice(0,1)
        const remain = val
        remain.forEach((coords) => {
            let antiNodePos = [];
            const xSlope = Math.abs(coords[0] - start[0])
            const ySlope = Math.abs(coords[1] - start[1])
            const slope = `slope ${xSlope}-x | ${ySlope}-y`
            if (((coords[1] + xSlope) > height) ||  ((coords[0] + ySlope) > length)) {

            }
            console.log(`Start is ${start}, compare to ${coords}, slope is ${slope}`)
            if (start[1] > coords[1]) {
                console.log('Higher start, check one slope above, twice the slop below')
                let upper = [start[0] + xSlope, start[1] + ySlope]
                let lower = [start[0] - xSlope*2, start[1] - ySlope*2]
                antiNodePos = [upper,lower]
            } else {
                console.log('Lower start, check twice slope above, one slop below')
                console.log('Higher start, check one slope above, twice the slop below')
                let upper = [start[0] + xSlope*2, start[1] + ySlope*2]
                let lower = [start[0] - xSlope, start[1] - ySlope]
                antiNodePos = [upper,lower]
            }
            if (rangeCheck(antiNodePos[0])) {
                antiNodes.add(`${antiNodePos[0][0]},${antiNodePos[0][1]}`)
            }
            if (rangeCheck(antiNodePos[1])) {
                antiNodes.add(`${antiNodePos[1][0]},${antiNodePos[1][1]}`)
            }
        })
    })
    console.log(antiNodes.size)
    console.log(antiNodes)
}
part1()


