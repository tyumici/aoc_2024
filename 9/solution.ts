import * as fs from 'fs';
let blocks: string ='';
const input = fs.readFileSync('/mnt/media/GIT/aoc_2024/9/input.txt', 'utf-8');
const numLength = input.length
let id = 0;
for(let i = 0; i < numLength; i +=2) {
    let file = Number(input.charAt(i))
    let freeSpace = Number(input.charAt(i+1))
    // console.log(`ID: ${id}: FILE: ${file}, FREE:${freeSpace}`)
    blocks = blocks.concat(`${id}`.repeat(file))
    blocks = blocks.concat('.'.repeat(freeSpace))
    id++
}

// console.log(blocks)
const empty = blocks.split(".").length - 1
const arrBlocks = [...blocks]

for(let i = blocks.length - 1; i > 0; i--) {
    if (typeof Number(arrBlocks[i-1]) === 'number') {
        for(let ii = 0; ii < blocks.length; ii++) {
            if (arrBlocks[ii] === '.') {
                arrBlocks[i] = '.'
                arrBlocks[ii] = arrBlocks[i-1]
            }
        }
    }
}

const blockString = arrBlocks.toString().replaceAll(',', '');
// console.log(blockString.substring(0,blocks.length - empty))
// console.log(empty)
const endVals = [...blockString].map(num => Number(num))
let part1 = 0;
endVals.forEach((val, index) => {
    part1 += val * index;
}) 
console.log(part1)
