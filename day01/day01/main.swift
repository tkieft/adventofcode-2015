//
//  main.swift
//  day01
//
//  Created by Tyler Kieft on 12/29/18.
//  Copyright © 2018 Tyler Kieft. All rights reserved.
//

import Foundation

let file = CommandLine.arguments[1]
let fileData = try String(contentsOfFile:file, encoding:String.Encoding.utf8)

var floor = 0
var positionEnteringBasement : Int?

for (i, c) in fileData.enumerated() {
    if c == "(" {
        floor += 1
    } else if c == ")" {
        floor -= 1
    }
    
    if floor < 0 && positionEnteringBasement == nil {
        positionEnteringBasement = i + 1
    }
}

print(floor)
print(positionEnteringBasement!)
