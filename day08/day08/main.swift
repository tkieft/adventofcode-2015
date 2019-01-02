//
//  main.swift
//  day08
//
//  Created by Tyler Kieft on 1/1/19.
//  Copyright © 2019 Tyler Kieft. All rights reserved.
//

import Foundation

let file = CommandLine.arguments[1]
let fileData = try String(contentsOfFile: file).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
let lines = fileData.components(separatedBy: CharacterSet.newlines)

var codeCount = 0
var encodedCount = 0
var memoryCount = 0

for line in lines {
    codeCount += line.count
    encodedCount += 6 // new end quotes, escaped original end quotes
    
    var i = line.index(line.startIndex, offsetBy: 1);
    let endIndex = line.index(before: line.endIndex)
    
    while i < endIndex {
        let c = line[i]
        
        if (c == "\\") {
            encodedCount += 2
            i = line.index(after: i)
            let c2 = line[i]
            if (c2 == "x") {
                encodedCount += 3
                memoryCount += 1
                i = line.index(i, offsetBy: 3)
            } else {
                encodedCount += 2
                memoryCount += 1
                i = line.index(after: i)
            }
        } else {
            memoryCount += 1
            encodedCount += 1
            i = line.index(after: i)
        }
    }
}

print(codeCount - memoryCount)
print(encodedCount - codeCount)
