//
//  main.swift
//  day17
//
//  Created by Tyler Kieft on 6/9/19.
//  Copyright © 2019 Tyler Kieft. All rights reserved.
//

import Foundation

extension String {
    func pad(with character: String, toLength length: Int) -> String {
        let padCount = length - self.count
        guard padCount > 0 else { return self }
        
        return String(repeating: character, count: padCount) + self
    }
}

let targetSum = 150

let file = CommandLine.arguments[1]
let fileData = try String(contentsOfFile: file)
let containers = fileData.components(separatedBy: CharacterSet.newlines).map({Int($0)})

let combos = Int(pow(Double(2), Double(containers.count)))

var hits = 0

var minContainersCount = 40
var minContainersHits = 0

for i in 0..<combos {
    var sum = 0
    var containersCount = 0
    
    let binary = String(i, radix:2).pad(with: "0", toLength: containers.count)
    
    for (index, char) in binary.enumerated() {
        if char == "1" {
            sum += containers[index]!
            containersCount += 1
        }
    }
    
    if (sum == targetSum) {
        hits += 1
    
        if (containersCount < minContainersCount) {
            minContainersCount = containersCount
            minContainersHits = 0
        }
        
        if (containersCount == minContainersCount) {
            minContainersHits += 1
        }
    }
}

print(hits)
print(minContainersHits)
