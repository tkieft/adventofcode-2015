//
//  main.swift
//  day16
//
//  Created by Tyler Kieft on 6/9/19.
//  Copyright © 2019 Tyler Kieft. All rights reserved.
//

import Foundation

let file = CommandLine.arguments[1]
let fileData = try String(contentsOfFile: file)
let lines = fileData.components(separatedBy: CharacterSet.newlines)

let targetSue: [String: Int] = [
    "children": 3,
    "cats": 7,
    "samoyeds": 2,
    "pomeranians": 3,
    "akitas": 0,
    "vizslas": 0,
    "goldfish": 5,
    "trees": 3,
    "cars": 2,
    "perfumes": 1
]

var sues = [[String: Int]]()

for line in lines {
    let words = line.components(separatedBy: CharacterSet.whitespaces)
    var sue = [String: Int]()
    var i = 2
    
    while i < words.count {
        let key = String(words[i].dropLast())
        let val = Int(i == words.count - 2 ? words[i + 1] : String(words[i + 1].dropLast()))
        sue[key] = val
        i += 2
    }
    
    sues.append(sue)
}

// Part 1
for (index, properties) in sues.enumerated() {
    
    var mismatch = false
    
    for (key, value) in properties {
        if (targetSue[key] != value) {
            mismatch = true
            break
        }
    }

    if !mismatch {
        print(index + 1)
        break
    }
}

// Part 2
for (index, properties) in sues.enumerated() {
    
    var mismatch = false
    
    for (key, value) in properties {
        if (key == "cats" || key == "trees") {
            if (targetSue[key]! >= value) {
                mismatch = true
                break
            }
        } else if (key == "pomeranians" || key == "goldfish") {
            if (targetSue[key]! <= value) {
                mismatch = true
                break
            }
        } else {
            if (targetSue[key] != value) {
                mismatch = true
                break
            }
        }
    }
    
    if !mismatch {
        print(index + 1)
        break
    }
}
