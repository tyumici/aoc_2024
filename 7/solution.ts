import * as fs from 'fs';
type Input = {
    test: number;
    inputs: number[];
};
const input = fs.readFileSync('/home/human/Documents/GIT/aoc_2024/7/input.txt', 'utf-8').split('\n').map(
    (line) => {
    const entry = line.split(':')
    const test = Number(entry[0]);
    const inputs = entry[1].split(' ').map(v => Number(v)).filter(n=> n !== 0)
    return {test, inputs: inputs}
}); 

console.log(input[0])

function part1(input: Input[]) {
    let sum = 0;
    for (const {inputs, test} of input) {
        const vals: Set<number> = new Set();
    }
}