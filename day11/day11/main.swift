//
//  main.swift
//  day11
//
//  Created by Tyler Kieft on 1/3/19.
//  Copyright © 2019 Tyler Kieft. All rights reserved.
//

import Foundation

var password = "cqjxjnds"

func incrementAscii(_ c: Character) -> String {
    let scalars = c.unicodeScalars
    return String(UnicodeScalar(scalars[scalars.startIndex].value + 1)!)
}

func increment(_ string: String) -> String {
    var newString = String()
    var increment = true
    var index = string.endIndex

    repeat {
        index = string.index(before: index)
        
        let c = string[index]
        
        if (increment) {
            if (c == "z") {
                newString.append("a")
            } else {
                newString.append(incrementAscii(c))
                increment = false
            }
        } else {
            newString.append(c)
        }
    } while index > string.startIndex
    
    return String(newString.reversed())
}

func isValid(_ password: String) -> Bool {
    if password.contains("i") { return false }
    if password.contains("l") { return false }
    if password.contains("o") { return false }
    
    var foundIncrease = false
    var increaseLength = 0

    var pairs = 0

    var lastPairC: Character? = nil
    var lastC: Character? = nil

    for c in password {
        if c == lastPairC {
            pairs += 1
            lastPairC = nil  // so we don't overlap pairs
        } else {
            lastPairC = c
        }
        
        if lastC != nil && c.unicodeScalars[c.unicodeScalars.startIndex].value == lastC!.unicodeScalars[lastC!.unicodeScalars.startIndex].value + 1 {
            increaseLength = increaseLength + 1
            if increaseLength == 3 {
                foundIncrease = true
            }
        } else {
            increaseLength = 1
        }

        lastC = c
    }
    
    return foundIncrease && (pairs >= 2)
}

func nextPassword(_ password: String) -> String {
    var pass = password
    repeat {
        pass = increment(pass)
    } while !isValid(pass)
    
    return pass
}

password = nextPassword(password)
print (password)
password = nextPassword(password)
print(password)
