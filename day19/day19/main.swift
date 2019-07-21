//
//  main.swift
//  day19
//
//  Created by Tyler Kieft on 7/20/19.
//  Copyright © 2019 Tyler Kieft. All rights reserved.
//

import Foundation

let file = CommandLine.arguments[1]
let fileData = try String(contentsOfFile: file)
let lines = fileData.components(separatedBy: CharacterSet.newlines)

struct Transformation {
    let from: String
    let to: String
    
    init(_ raw:String) {
        let components = raw.components(separatedBy: " => ")
        self.from = components[0]
        self.to = components[1]
    }
}

let startMolecule: String = lines[lines.count - 1]
let entireMolecule = NSRange(location:0, length:startMolecule.count)
let transformations = lines[0..<lines.count - 2].map({Transformation($0)})

// Part One
var molecules = Set<String>()

transformations.forEach { (transformation: Transformation) in
    let regex = try? NSRegularExpression(pattern: transformation.from)
    regex?.enumerateMatches(in: startMolecule, options: NSRegularExpression.MatchingOptions(), range: entireMolecule, using: { (result: NSTextCheckingResult?, _, _) in

        var newMolecule = startMolecule
        newMolecule.replaceSubrange(Range(result!.range, in:newMolecule)!, with: transformation.to)
        molecules.insert(newMolecule)
    })
}

print(molecules.count)

// Part Two

let sortedTransformations = transformations.sorted { $0.to.count > $1.to.count }
var workingMolecule = startMolecule
var steps = 0

while (workingMolecule.count > 1) {
    for transformation in sortedTransformations {
        let regex = try? NSRegularExpression(pattern: transformation.to)
        let matches = regex?.matches(in: workingMolecule, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length:workingMolecule.count))
        
        for match in matches?.reversed() ?? [] {
            workingMolecule.replaceSubrange(Range(match.range, in:workingMolecule)!, with: transformation.from)
            steps += 1
        }
    }
}

print(steps)
