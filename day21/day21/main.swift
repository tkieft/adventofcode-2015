//
//  main.swift
//  day21
//
//  Created by Tyler Kieft on 7/27/19.
//  Copyright © 2019 Tyler Kieft. All rights reserved.
//

import Foundation

class Player {
    var hitPoints: Int
    var damage: Int
    var armor: Int
    
    init(hitPoints: Int, damage: Int, armor: Int) {
        self.hitPoints = hitPoints
        self.damage = damage
        self.armor = armor
    }
}

struct Item: Equatable {
    let name: String
    let cost: Int
    let damage: Int
    let armor: Int
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name &&
            lhs.cost == rhs.cost &&
            lhs.damage == rhs.damage &&
            lhs.armor == rhs.armor
    }
}

let weapons = [
    Item(name: "Dagger", cost: 8, damage: 4, armor: 0),
    Item(name: "Shortsword", cost: 10, damage: 5, armor: 0),
    Item(name: "Warhammer", cost: 25, damage: 6, armor: 0),
    Item(name: "Longsword", cost: 40, damage: 7, armor: 0),
    Item(name: "Greataxe", cost: 74, damage: 8, armor: 0)
]

let armor = [
    Item(name: "None", cost: 0, damage: 0, armor: 0),
    Item(name: "Leather", cost: 13, damage: 0, armor: 1),
    Item(name: "Chainmail", cost: 31, damage: 0, armor: 2),
    Item(name: "Splintmail", cost: 53, damage: 0, armor: 3),
    Item(name: "Bandedmail", cost: 75, damage: 0, armor: 4),
    Item(name: "Platemail", cost: 102, damage: 0, armor: 5),
]

let rings = [
    Item(name: "None", cost: 0, damage: 0, armor: 0),
    Item(name: "Damage +1", cost: 25, damage: 1, armor: 0),
    Item(name: "Damage +2", cost: 50, damage: 2, armor: 0),
    Item(name: "Damage +3", cost: 100, damage: 3, armor: 0),
    Item(name: "Defense +1", cost: 20, damage: 0, armor: 1),
    Item(name: "Defense +2", cost: 40, damage: 0, armor: 2),
    Item(name: "Defense +3", cost: 80, damage: 0, armor: 3),
]

// returns true if player won
func simulateFight(player: Player, boss: Player) -> Bool {
    var currentPlayer = player
    var otherPlayer = boss

    while true {
        otherPlayer.hitPoints -= max(1, currentPlayer.damage - otherPlayer.armor)
        
        if (otherPlayer.hitPoints <= 0) {
            return currentPlayer === player
        }
        
        swap(&currentPlayer, &otherPlayer)
    }
}

// Part 1

var minGold = Int.max

for weapon in weapons {
    for armor in armor {
        for ring1 in rings {
            for ring2 in rings {
                if (ring1.cost > 0 && ring1 == ring2) {
                    continue
                }
                
                let player = Player(hitPoints: 100, damage: weapon.damage + ring1.damage + ring2.damage, armor: armor.armor + ring1.armor + ring2.armor)
                let boss = Player(hitPoints: 109, damage: 8, armor: 2)
                
                if simulateFight(player: player, boss: boss) {
                    let cost = weapon.cost + armor.cost + ring1.cost + ring2.cost
                    if cost < minGold {
                        minGold = cost
                    }
                }
            }
        }
    }
}

print(minGold)

// Part 2
var maxGold = 0

for weapon in weapons {
    for armor in armor {
        for ring1 in rings {
            for ring2 in rings {
                if (ring1.cost > 0 && ring1 == ring2) {
                    continue
                }
                
                let player = Player(hitPoints: 100, damage: weapon.damage + ring1.damage + ring2.damage, armor: armor.armor + ring1.armor + ring2.armor)
                let boss = Player(hitPoints: 109, damage: 8, armor: 2)
                
                if !simulateFight(player: player, boss: boss) {
                    let cost = weapon.cost + armor.cost + ring1.cost + ring2.cost
                    if cost > maxGold {
                        maxGold = cost
                    }
                }
            }
        }
    }
}

print(maxGold)
