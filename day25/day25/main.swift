//
//  main.swift
//  day25
//
//  Created by Tyler Kieft on 7/28/19.
//  Copyright © 2019 Tyler Kieft. All rights reserved.
//

import Foundation

var row = 1
var col = 1
var code = 20151125

while row != 2978 || col != 3083 {
    if row == 1 {
        row = col + 1
        col = 1
    } else {
        row = row - 1
        col = col + 1
    }
    
    code = code * 252533 % 33554393
}

print(code)
