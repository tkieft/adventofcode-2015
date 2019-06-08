//
//  main.swift
//  day14
//
//  Created by Tyler Kieft on 6/7/19.
//  Copyright © 2019 Tyler Kieft. All rights reserved.
//

import Foundation

struct Reindeer {
    let name: String
    let flyingSpeed: Int
    let flyingTime: Int
    let restTime: Int
}

class Part2Race {
    let reindeer: Reindeer
    var points: Int
    var distance: Int
    var flying: Bool
    var timeLeft: Int
    
    init(_ reindeer: Reindeer) {
        self.reindeer = reindeer
        self.points = 0
        self.distance = 0
        self.flying = true
        self.timeLeft = reindeer.flyingTime
    }
}

let SIMULATION_TIME = 2503

let file = CommandLine.arguments[1]
let fileData = try String(contentsOfFile: file)
let lines = fileData.components(separatedBy: CharacterSet.newlines)

var reindeer = [Reindeer]()

for line in lines {
    let words = line.components(separatedBy: CharacterSet.whitespaces)
    reindeer.append(Reindeer(
        name: words[0],
        flyingSpeed: Int(words[3])!,
        flyingTime: Int(words[6])!,
        restTime: Int(words[13])!
    ))
}

// PART 1

var distances = reindeer.map({(r: Reindeer) -> Int in
    var t = SIMULATION_TIME
    var distance = 0
    
    while t > 0 {
        distance += min(t, r.flyingTime) * r.flyingSpeed
        t -= r.flyingTime
        t -= r.restTime
    }
    
    return distance
})

print(distances.max()!)

// PART 2

let race = reindeer.map({Part2Race($0)})

for _ in 0..<SIMULATION_TIME {
    for racer in race {
        if (racer.flying) {
            racer.distance += racer.reindeer.flyingSpeed
        }

        racer.timeLeft -= 1
        
        if (racer.timeLeft == 0) {
            racer.flying = !racer.flying
            racer.timeLeft = racer.flying ? racer.reindeer.flyingTime : racer.reindeer.restTime
        }
    }
    
    let maxRacer = race.max { return $0.distance < $1.distance }!
    
    for racer in race {
        if racer.distance == maxRacer.distance {
            racer.points += 1
        }
    }
}

print(race.max { return $0.points < $1.points }!.points)
