//
//  main.swift
//  day13
//
//  Created by Tyler Kieft on 6/7/19.
//  Copyright © 2019 Tyler Kieft. All rights reserved.
//

import Foundation

func swap<T>(_ array: inout [T], _ a: Int, _ b: Int) {
    let temp = array[a]
    array[a] = array[b]
    array[b] = temp
}

// Heaps Algorithm
func permute<T>(_ a: inout [T], _ n: Int, _ eachPermutation: ([T]) -> Void) {
    if n == 1 {
        // (got a new permutation)
        eachPermutation(a)
        return
    }
    
    for i in 0..<n-1 {
        permute(&a, n-1, eachPermutation);
        // always swap the first when odd,
        // swap the i-th when even
        if n % 2 == 0 {
            swap(&a, n-1, i);
        }
        else {
            swap(&a, n-1, 0);
        }
    }
    
    permute(&a, n-1, eachPermutation)
}

func permute(_ names: inout [String], _ eachPermutation: ([String]) -> Void) {
    permute(&names, names.count, eachPermutation)
}

func calculateMaxHappiness(_ happiness: [String: [String: Int]]) -> Int {
    var maxHappiness = 0
    var names = Array(happiness.keys)

    permute(&names, { seating in
        var happinessTotal = 0
        
        for (index, name) in seating.enumerated() {
            happinessTotal += happiness[name]![seating[(index + 1) % seating.count]]!
            happinessTotal += happiness[name]![seating[(index + seating.count - 1) % seating.count]]!
        }
        
        if (happinessTotal > maxHappiness) {
            maxHappiness = happinessTotal
        }
    })
    
    return maxHappiness
}

let file = CommandLine.arguments[1]
let fileData = try String(contentsOfFile: file)
let lines = fileData.components(separatedBy: CharacterSet.newlines)

var happiness = [String: [String: Int]]()

// Parse Input
for line in lines {
    let words = line.components(separatedBy: CharacterSet.whitespaces)
    let name1 = words[0]
    let name2 = String(words[words.count - 1].dropLast())
    let increment = Int(words[3])! * (words[2] == "lose" ? -1 : 1)
    
    happiness[name1, default:[String: Int]()][name2] = increment
}

// Calculate optimal seating (Part I)
print(calculateMaxHappiness(happiness))

happiness["Tyler"] = [String:Int]()

// Add self
for (key, _) in happiness {
    happiness["Tyler"]![key] = 0
    happiness[key]!["Tyler"] = 0
}
// Calculate optimal seating with self (Part II)
print (calculateMaxHappiness(happiness))
