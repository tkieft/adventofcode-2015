//
//  main.swift
//  day15
//
//  Created by Tyler Kieft on 6/8/19.
//  Copyright © 2019 Tyler Kieft. All rights reserved.
//

import Foundation

class Ingredient {
    let capacity: Int
    let durability: Int
    let flavor: Int
    let texture: Int
    let calories: Int
    
    init(capacity: Int, durability: Int, flavor: Int, texture: Int, calories: Int) {
        self.capacity = capacity
        self.durability = durability
        self.flavor = flavor
        self.texture = texture
        self.calories = calories
    }
}

func generateQuantities(elementCount: Int, sum: Int, arr: [Int], eachQuantity: ([Int]) -> Void) {
    if (elementCount == 1) {
        var newArray = arr
        newArray.append(sum)
        eachQuantity(newArray)
        return
    }
    
    for i in 0...sum {
        var newArray = arr
        newArray.append(i)
        generateQuantities(elementCount: elementCount - 1, sum: sum - i, arr: newArray, eachQuantity: eachQuantity)
    }
}

func generateQuantities(elementCount: Int, sum: Int, eachQuantity: ([Int]) -> Void) {
    generateQuantities(elementCount: elementCount, sum: sum, arr: [], eachQuantity: eachQuantity)
}

func getScore(ingredients: [Ingredient], quantities: [Int]) -> Int {
    let capacity =   quantities.enumerated().map({ (index, element) in element * ingredients[index].capacity }).reduce(0, +)
    let durability = quantities.enumerated().map({ (index, element) in element * ingredients[index].durability }).reduce(0, +)
    let flavor =     quantities.enumerated().map({ (index, element) in element * ingredients[index].flavor }).reduce(0, +)
    let texture =    quantities.enumerated().map({ (index, element) in element * ingredients[index].texture }).reduce(0, +)
    
    if (capacity <= 0 || durability <= 0 || flavor <= 0 || texture <= 0) {
        return 0
    }
    
    return capacity * durability * flavor * texture
}

let testIngredients = [
    Ingredient(capacity: -1, durability: -2, flavor: 6, texture: 3, calories: 8), // butterscotch
    Ingredient(capacity: 2, durability: 3, flavor: -2, texture: -1, calories: 3)  // cinnamon
]

let ingredients = [
    Ingredient(capacity: 2, durability: 0, flavor: -2, texture: 0, calories: 3), // sprinkles
    Ingredient(capacity: 0, durability: 5, flavor: -3, texture: 0, calories: 3), // butterscotch
    Ingredient(capacity: 0, durability: 0, flavor: 5, texture: -1, calories: 8), // chocolate
    Ingredient(capacity: 0, durability: -1, flavor: 0, texture: 5, calories: 8) // candy
]

// Part 1

var maxScore = 0

generateQuantities(elementCount: ingredients.count, sum: 100, eachQuantity: { (quantities: [Int]) -> Void in
    maxScore = max(getScore(ingredients: ingredients, quantities: quantities), maxScore)
})

print(maxScore)

// Part 2

maxScore = 0

generateQuantities(elementCount: ingredients.count, sum: 100, eachQuantity: { (quantities: [Int]) -> Void in
    let calories = quantities.enumerated().map({ (index, element) in element * ingredients[index].calories }).reduce(0, +)
    
    if (calories == 500) {
        maxScore = max(getScore(ingredients: ingredients, quantities: quantities), maxScore)
    }
})

print(maxScore)
