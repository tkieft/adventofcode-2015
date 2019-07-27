//
//  main.swift
//  day23
//
//  Created by Tyler Kieft on 7/27/19.
//  Copyright © 2019 Tyler Kieft. All rights reserved.
//

import Foundation

enum InstructionError: Error {
    case notFound
}

let file = CommandLine.arguments[1]
let fileData = try String(contentsOfFile: file)
let instructions = fileData.components(separatedBy: CharacterSet.newlines)

var r = ["a": 1, "b": 0]
var pc = 0

while pc < instructions.count {
    let instruction = instructions[pc]
    let i: [String] = instruction.components(separatedBy: " ")
    let op = i[0]
    
    switch op {
    case "hlf":
        r[i[1]]! /= 2
        pc += 1
    case "tpl":
        r[i[1]]! *= 3
        pc += 1
    case "inc":
        r[i[1]]! += 1
        pc += 1
    case "jmp":
        pc += Int(i[1])!
    case "jie":
        let register = String(i[1][i[1].startIndex])
        if r[register]! % 2 == 0 {
            pc += Int(i[2])!
        } else {
            pc += 1
        }
    case "jio":
        let register = String(i[1][i[1].startIndex])
        if r[register] == 1 {
            pc += Int(i[2])!
        } else {
            pc += 1
        }
    default:
        throw InstructionError.notFound
    }
}

print(r["b"]!)
