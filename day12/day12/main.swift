//
//  main.swift
//  day12
//
//  Created by Tyler Kieft on 1/3/19.
//  Copyright © 2019 Tyler Kieft. All rights reserved.
//

import Foundation

func handleValue(_ value: Any, ignoreRed: Bool) -> Int {
    if value is Int {
        return value as! Int
    } else if value is [String: Any] {
        return dictionarySum(value as! [String: Any], ignoreRed: ignoreRed)
    } else if value is [Any] {
        return arraySum(value as! [Any], ignoreRed: ignoreRed)
    }

    return 0
}

func arraySum(_ array: [Any], ignoreRed: Bool) -> Int {
    return array.reduce(0, { $0 + handleValue($1, ignoreRed: ignoreRed) })
}

func dictionarySum(_ dictionary: Dictionary<String, Any>, ignoreRed: Bool = false) -> Int {
    if ignoreRed && dictionary.values.contains(where: { (value) -> Bool in value is String && (value as! String) == "red" }) {
        return 0
    }

    return dictionary.reduce(0, { $0 + handleValue($1.value, ignoreRed: ignoreRed) })
}

let file = CommandLine.arguments[1]
let data = try Data(contentsOf: URL(fileURLWithPath: file))
let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]

print(dictionarySum(json))
print(dictionarySum(json, ignoreRed: true))
