//
//  main.swift
//  day02
//
//  Created by Tyler Kieft on 12/29/18.
//  Copyright © 2018 Tyler Kieft. All rights reserved.
//

import Foundation

struct Box {
    let l: Int
    let w: Int
    let h: Int
}

let file = CommandLine.arguments[1]
let fileData = try String(contentsOfFile: file).trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
let lines = fileData.components(separatedBy: "\n")

var boxes: [Box] = []

for line in lines {
    let lwh = line.components(separatedBy: "x")
    boxes.append(Box(l: Int(lwh[0])!, w: Int(lwh[1])!, h: Int(lwh[2])!))
}

var wrappingPaperArea = 0
var ribbonLength = 0

for box in boxes {
    let lw = box.l * box.w
    let wh = box.w * box.h
    let lh = box.l * box.h
    
    // surface area
    wrappingPaperArea += 2 * lw + 2 * wh + 2 * lh
    
    // slack: area of smallest side
    wrappingPaperArea += min(min(lw, wh), lh)
    
    // perimeter of smallest side
    ribbonLength += 2 * (box.l + box.w + box.h - max(max(box.l, box.w), box.h))
    
    // bow: cubic volume
    ribbonLength += box.l * box.w * box.h
}

print(wrappingPaperArea)
print(ribbonLength)
