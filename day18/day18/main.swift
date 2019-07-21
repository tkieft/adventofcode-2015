//
//  main.swift
//  day18
//
//  Created by Tyler Kieft on 6/9/19.
//  Copyright © 2019 Tyler Kieft. All rights reserved.
//

import Foundation

let file = CommandLine.arguments[1]
let fileData = try String(contentsOfFile: file)
let lines = fileData.components(separatedBy: CharacterSet.newlines)

let board = lines.map{ Array($0) }

func getNeighbor(board: [[Character]], y: Int, x: Int, yDelta: Int, xDelta: Int) -> Character {
    
    if ((y == 0 && yDelta == -1) ||
        (y == board.count - 1 && yDelta == 1) ||
        (x == 0 && xDelta == -1) ||
        (x == board[y].count - 1 && xDelta == 1)){
        return "."
    }
    
    return board[y + yDelta][x + xDelta]
}

func countNeighborsOn(board: [[Character]], y: Int, x: Int) -> Int {
    var count = 0
    
    for yDelta in -1...1 {
        for xDelta in -1...1 {
            if xDelta == 0 && yDelta == 0 {
                continue
            }
            count += getNeighbor(board: board, y: y, x: x, yDelta: yDelta, xDelta: xDelta) == "#" ? 1 : 0
        }
    }

    return count
}

func countLightsOn(board: [[Character]]) -> Int {
    return board.reduce(0, { (partialSum: Int, row: [Character]) -> Int in
        return partialSum + row.reduce(0, {$0 + ($1 == "#" ? 1 : 0)})
    })
}

func doStep(board: [[Character]]) -> [[Character]] {
    var newBoard = board
    for y in 0..<board.count {
        for x in 0..<board[y].count {
            let light = board[y][x]
            let neighborsOn = countNeighborsOn(board: board, y: y, x: x)
            
            if light == "#" && !(neighborsOn == 2 || neighborsOn == 3) {
                newBoard[y][x] = "."
            } else if light == "." && (neighborsOn == 3) {
                newBoard[y][x] = "#"
            }
        }
    }
    return newBoard
}

func turnCornersOn(board: inout [[Character]]) {
    board[0][0] = "#"
    board[0][board[0].count - 1] = "#"
    board[board.count - 1][0] = "#"
    board[board.count - 1][board[board.count - 1].count - 1] = "#"
}

// Part 1
var part1board = board
for _ in 0..<100 {
    part1board = doStep(board: part1board)
}
print(countLightsOn(board: part1board))

// Part II
var part2board = board
for _ in 0..<100 {
    turnCornersOn(board: &part2board)
    part2board = doStep(board: part2board)
}
turnCornersOn(board: &part2board)
print(countLightsOn(board: part2board))

