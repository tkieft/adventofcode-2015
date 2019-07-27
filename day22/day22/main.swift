//
//  main.swift
//  day22
//
//  Created by Tyler Kieft on 7/27/19.
//  Copyright © 2019 Tyler Kieft. All rights reserved.
//

import Foundation

struct Player {
    var hitPoints: Int
    var mana: Int
    var damage: Int
    var armor: Int
}

struct GameState {
    var player: Player
    var boss: Player
    var manaSpent: Int
    var playersTurn: Bool
    
    var shieldTurns: Int
    var poisonTurns: Int
    var rechargeTurns: Int
}

func simulateGame(_ hard: Bool) {
    var states = Heap<GameState>(sort: { $0.manaSpent == $1.manaSpent ? $0.boss.hitPoints < $1.boss.hitPoints : $0.manaSpent < $1.manaSpent })

    states.insert(GameState(
        player: Player(hitPoints: 50, mana: 500, damage: 0, armor: 0),
        boss: Player(hitPoints: 58, mana: 0, damage: 9, armor: 0),
        manaSpent: 0,
        playersTurn: true,
        shieldTurns: 0,
        poisonTurns: 0,
        rechargeTurns: 0
    ))

    while true {
        let currentState = states.remove()!
        
        // Base object for new state generated after this turn
        var newState = currentState
        newState.playersTurn = !currentState.playersTurn
        
        if (hard && currentState.playersTurn) {
            newState.player.hitPoints -= 1
        }
        
        if (newState.player.hitPoints <= 0 ||
            (currentState.playersTurn && currentState.player.mana < 53)) {
            // Losing outcome, continue
            continue
        }
        
        // Apply shield effect
        if (newState.shieldTurns > 0) {
            newState.shieldTurns -= 1
            
            if (newState.shieldTurns == 0) {
                newState.player.armor = 0
            }
        }
        
        // Apply poison effect
        if (newState.poisonTurns > 0) {
            newState.boss.hitPoints -= 3
            newState.poisonTurns -= 1
        }
        
        // Apply recharge effect
        if (newState.rechargeTurns > 0) {
            newState.player.mana += 101
            newState.rechargeTurns -= 1
        }
        
        if (newState.boss.hitPoints <= 0) {
            // Winning outcome, stop
            print(newState.manaSpent)
            break
        }

        if (currentState.playersTurn) {
            if (newState.player.mana >= 53) {
                var missileState = newState
                missileState.player.mana -= 53
                missileState.manaSpent += 53
                missileState.boss.hitPoints -= 4
                states.insert(missileState)
            }
            
            if (newState.player.mana >= 73) {
                var drainState = newState
                drainState.player.mana -= 73
                drainState.manaSpent += 73
                drainState.boss.hitPoints -= 2
                drainState.player.hitPoints += 2
                states.insert(drainState)
            }
            
            if (newState.shieldTurns == 0 && newState.player.mana >= 113) {
                var shieldState = newState
                shieldState.player.mana -= 113
                shieldState.manaSpent += 113
                shieldState.shieldTurns = 6
                shieldState.player.armor = 7
                states.insert(shieldState)
            }
            
            if (newState.poisonTurns == 0 && newState.player.mana >= 173) {
                var poisonState = newState
                poisonState.player.mana -= 173
                poisonState.manaSpent += 173
                poisonState.poisonTurns = 6
                states.insert(poisonState)
            }
            
            if (newState.rechargeTurns == 0 && newState.player.mana >= 229) {
                var rechargeState = newState
                rechargeState.player.mana -= 229
                rechargeState.manaSpent += 229
                rechargeState.rechargeTurns = 5
                states.insert(rechargeState)
            }
        } else {
            newState.player.hitPoints -= max(1, currentState.boss.damage - newState.player.armor)
            states.insert(newState)
        }
    }
}

simulateGame(false)
simulateGame(true)
