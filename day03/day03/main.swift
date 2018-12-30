//
//  main.swift
//  day03
//
//  Created by Tyler Kieft on 12/29/18.
//  Copyright © 2018 Tyler Kieft. All rights reserved.
//

import Foundation

class House {
    var presentCount: UInt
    
    init() {
        presentCount = 0
    }
}

let GRID_SIZE = 1000

let file = CommandLine.arguments[1]
let moves = try String(contentsOfFile: file)

func deliverPresents(workers: Int) -> Int {
    var houses = [[House?]](repeating: Array<House?>(repeating: nil, count: GRID_SIZE), count: GRID_SIZE)
    
    var locations = [(Int, Int)](repeating:(GRID_SIZE / 2, GRID_SIZE / 2), count:workers)
    
    var location = locations[0];
    houses[location.0][location.1] = House()
    houses[location.0][location.1]!.presentCount += 1
    
    for (i, move) in moves.enumerated() {
        location = locations[i % workers]
        
        if (move == "^") {
            location.0 -= 1;
        } else if (move == ">") {
            location.1 += 1;
        } else if (move == "v") {
            location.0 += 1;
        } else if (move == "<") {
            location.1 -= 1;
        }
        
        if (houses[location.0][location.1] == nil) {
            houses[location.0][location.1] = House()
        }
        
        houses[location.0][location.1]!.presentCount += 1

        locations[i % workers] = location
    }
    
    return houses.reduce(0, { $0 + $1.reduce(0, { $0 + ($1 == nil ? 0 : 1) }) })
}

print(deliverPresents(workers: 1))
print(deliverPresents(workers: 2))
