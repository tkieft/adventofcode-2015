//
//  main.swift
//  day24
//
//  Created by Tyler Kieft on 7/27/19.
//  Copyright © 2019 Tyler Kieft. All rights reserved.
//

import Foundation

let testPackages = [1,2,3,4,5,7,8,9,10,11]
let packages = [1,3,5,11,13,17,19,23,29,31,37,41,43,47,53,59,67,71,73,79,83,89,97,101,103,107,109,113]

// Generic function to generate all combinations of size combinationSize in a list of itemCount items
// Return true as soon as forEach returns true, otherwise false
func allCombinations(itemCount: Int, combinationSize: Int, forEach: ([Int]) -> Bool) -> Bool {
    var combination = [Int](repeating: 0, count: combinationSize)

    for i in 0..<combinationSize {
        combination[i] = i
    }
    
    while true {
        if forEach(combination) {
            // Result found
            return true
        }
        
        // Calculate next
        var i = combinationSize - 1
        combination[i] += 1
        if combination[i] >= itemCount {
            while combination[i] >= (itemCount - (combinationSize - 1 - i)) && i > 0 {
                i -= 1
                combination[i] += 1
            }
            if i == 0 && combination[i] > itemCount - combinationSize {
                // No result found
                return false
            }
            while (i < combinationSize - 1) {
                i += 1
                combination[i] = combination[i - 1] + 1
            }
        }
    }
}

// Find the first combination which matches the given predicate
// Return true as soon as a predicate matches, false if no combination found
func findCombination(elements: [Int], predicate: ([Int], [Int]) -> Bool) -> Bool {
    for size in 1...elements.count {
        let foundResult = allCombinations(itemCount: elements.count, combinationSize: size, forEach: { (combination: [Int]) in
            let selection = combination.map({ elements[$0] })
            var remainder = elements
            
            for i in 0..<combination.count {
                remainder.remove(at: combination[i] - i)
            }
            
            return predicate(selection, remainder);
        })
        
        if foundResult {
            return true
        }
    }
    return false
}

func qe(packages: [Int]) -> Int {
    return packages.reduce(1, *)
}

// Part 1

let _ = findCombination(elements: packages, predicate: { (selection: [Int], leftover: [Int]) in
    let weight = selection.reduce(0, +)
    
    // Shortcut if statement to bypass combination logic in certain cases
    if leftover.reduce(0, +) == weight * 2 {
        if findCombination(elements: leftover, predicate: { $0.reduce(0, +) == $1.reduce(0, +) }) {
            print(qe(packages: selection))
            return true
        }
    }
    return false
})

// Part 2

let _ = findCombination(elements: packages, predicate: { (selection: [Int], leftover: [Int]) in
    let weight = selection.reduce(0, +)
    
    // Shortcut if statement to bypass combination logic in certain cases
    if leftover.reduce(0, +) == weight * 3 {
        return findCombination(elements: leftover, predicate: { (selection2: [Int], leftover2: [Int]) -> Bool in
            if selection2.reduce(0, +) == weight && leftover2.reduce(0, +) == 2 * weight {
                if findCombination(elements: leftover2, predicate: { $0.reduce(0, +) == $1.reduce(0, +) }) {
                    print(qe(packages: selection))
                    return true
                }
            }
            return false
        })
    }
    return false
})
