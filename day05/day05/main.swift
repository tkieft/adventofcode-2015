//
//  main.swift
//  day05
//
//  Created by Tyler Kieft on 12/30/18.
//  Copyright © 2018 Tyler Kieft. All rights reserved.
//

import Foundation

func isNice(_ line: String) -> Bool {
    let disallowed = ["ab", "cd", "pq", "xy"]
    for string in disallowed {
        if line.contains(string) {
            return false
        }
    }
    
    let vowels : [Character] = ["a", "e", "i", "o", "u"]
    var vowelCount = 0
    var lastC : Character? = nil
    var foundDuplicate = false
    
    for c in line {
        if vowels.contains(c) {
            vowelCount += 1
        }
        
        if (c == lastC) {
            foundDuplicate = true
        }
        lastC = c
    }
    
    return vowelCount >= 3 && foundDuplicate
}

func isNiceNew(_ line: String) -> Bool {
    var twoPreviousC : Character? = nil
    var previousC : Character? = nil
    var foundDuplicate = false
    
    // test for duplicates
    for c in line {
        if (c == twoPreviousC) {
            foundDuplicate = true
        }
        twoPreviousC = previousC
        previousC = c
    }
    
    if (!foundDuplicate) {
        return false
    }
    
    // test for pairs of pairs
    for i in (0..<line.count - 3) {
        let start = line.index(line.startIndex, offsetBy: i)
        let end = line.index(line.startIndex, offsetBy: i + 2)
        let searchPattern = line[start..<end]
        let restOfLine = line[end..<line.endIndex]

        if restOfLine.contains(searchPattern) {
            return true
        }
    }

    return false
}

let file = CommandLine.arguments[1]
let fileData = try String(contentsOfFile: file)
let lines = fileData.components(separatedBy: CharacterSet.newlines)

print(lines.filter({ isNice($0) }).count)
print(lines.filter({ isNiceNew($0) }).count)
