//
//  main.swift
//  day06
//
//  Created by Tyler Kieft on 12/30/18.
//  Copyright © 2018 Tyler Kieft. All rights reserved.
//

import Foundation

enum Operation {
    case TURN_OFF
    case TURN_ON
    case TOGGLE
}

let file = CommandLine.arguments[1]
let fileData = try String(contentsOfFile: file).trimmingCharacters(in: CharacterSet.newlines)
let lines = fileData.components(separatedBy: CharacterSet.newlines)

func calcBrightness(new: Bool) -> Int {
    var lights = [[Int]](repeating: Array<Int>(repeating: 0, count: 1000), count: 1000)

    for line in lines {
        let instructions = line.components(separatedBy: CharacterSet.whitespaces)

        let operation = (instructions[0] == "toggle" ? Operation.TOGGLE :
            (instructions[1] == "on" ? Operation.TURN_ON : Operation.TURN_OFF))
        
        let index = operation == Operation.TOGGLE ? 1 : 2;
        let startCoords = instructions[index].components(separatedBy: ",").map({ Int($0)! })
        let endCoords = instructions[index + 2].components(separatedBy: ",").map({ Int($0)! })

        for x in (CountableClosedRange<Int>(uncheckedBounds: (lower:startCoords[0], upper:endCoords[0]))) {
            for y in (CountableClosedRange<Int>(uncheckedBounds: (lower:startCoords[1], upper:endCoords[1]))) {
                switch operation {
                case .TURN_OFF: lights[x][y] = new ? max(lights[x][y] - 1, 0) : 0
                case .TURN_ON: lights[x][y] = new ? lights[x][y] + 1 : 1
                case .TOGGLE: lights[x][y] = new ? lights[x][y] + 2 : (lights[x][y] == 0 ? 1 : 0)
                }
            }
        }
    }
    return lights.reduce(0, { $0 + $1.reduce(0, {$0 + $1}) })
}

print(calcBrightness(new: false))
print(calcBrightness(new: true))
