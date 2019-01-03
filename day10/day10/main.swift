//
//  main.swift
//  day10
//
//  Created by Tyler Kieft on 1/2/19.
//  Copyright © 2019 Tyler Kieft. All rights reserved.
//

import Foundation

func transform(_ number: String) -> String {
    var newNumber = String()
    
    var index = number.startIndex
    
    repeat {
        let c = number[index]
        var cCount = 0
    
        while (index < number.endIndex && number[index] == c) {
            cCount += 1
            index = number.index(after: index)
        }
        
        newNumber.append(String(cCount))
        newNumber.append(c)
        
    } while index < number.endIndex

    return newNumber
}

var input = "3113322113"

for _ in (0..<40) {
    input = transform(input)
}

print(input.count)

for _ in (0..<10) {
    input = transform(input)
}

print(input.count)
