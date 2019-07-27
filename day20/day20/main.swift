//
//  main.swift
//  day20
//
//  Created by Tyler Kieft on 7/21/19.
//  Copyright © 2019 Tyler Kieft. All rights reserved.
//

import Foundation

let TARGET_PRESENTS = 36000000

// Part 1

var i = 2

while true {
    var presents = 0
    let root = Int(sqrt(Double(i)))
    
    for j in 1...root {
        if i % j == 0 {
            presents += j * 10

            let other = i / j
            if (other != j) {
                presents += other * 10
            }
        }
    }
    
    if (presents >= TARGET_PRESENTS) {
        break
    }
    
    i += 2
}

print(i)

// Part 2

while true {
    var presents = 0
    let root = Int(sqrt(Double(i)))
    
    for j in 1...root {
        if i % j == 0 {
            let other = i / j

            if (other <= 50) {
                presents += j * 11
            }
            
            if (j <= 50 && other != j) {
                presents += other * 11
            }
        }
    }
    
    if (presents >= TARGET_PRESENTS) {
        break
    }
    
    i += 2
}

print(i)
