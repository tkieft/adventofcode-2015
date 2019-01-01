//
//  main.swift
//  day07
//
//  Created by Tyler Kieft on 12/31/18.
//  Copyright © 2018 Tyler Kieft. All rights reserved.
//

import Foundation

class Wire {
    var cachedValue: Int?
    let operation: String
    
    init(_ operation: String) {
        self.operation = operation
    }
    
    private func intOrValue(_ operand: String, circuit: [String: Wire]) -> Int {
        if let operandAsInt = Int(operand) {
            return operandAsInt
        }
        return circuit[operand]!.value(circuit)
    }
    
    func value(_ circuit: [String: Wire]) -> Int {
        if (cachedValue != nil) {
            return cachedValue!
        }
        
        let tokens = operation.components(separatedBy: CharacterSet.whitespaces)
        
        if tokens.count == 1 {
            cachedValue = intOrValue(tokens[0], circuit: circuit)
        } else if tokens[0] == "NOT" {
            cachedValue = ~(circuit[tokens[1]]!.value(circuit))
        } else if tokens[1] == "AND" {
            cachedValue = intOrValue(tokens[0], circuit: circuit) & intOrValue(tokens[2], circuit: circuit)
        } else if tokens[1] == "OR" {
            cachedValue = intOrValue(tokens[0], circuit: circuit) | intOrValue(tokens[2], circuit: circuit)
        } else if tokens[1] == "LSHIFT" {
            cachedValue = circuit[tokens[0]]!.value(circuit) << Int(tokens[2])!
        } else if tokens[1] == "RSHIFT" {
            cachedValue = circuit[tokens[0]]!.value(circuit) >> Int(tokens[2])!
        }
        
        return cachedValue!
    }
}

let file = CommandLine.arguments[1]
let fileData = try String(contentsOfFile: file).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
let lines = fileData.components(separatedBy: CharacterSet.newlines)

// mapping of wire name to wire
var circuit = [String: Wire]()

for line in lines {
    let sides = line.components(separatedBy: " -> ");
    circuit[sides[1]] = Wire(sides[0])
}

// Part I: Calculate Value on wire "a"
let aValue = circuit["a"]!.value(circuit)
print(aValue)

// Part II: Reset circuit cached values and start with a value as b's value
for (_, value) in circuit {
    value.cachedValue = nil
}

circuit["b"]?.cachedValue = aValue

// Recalculate value on wire "a"
print(circuit["a"]!.value(circuit))
