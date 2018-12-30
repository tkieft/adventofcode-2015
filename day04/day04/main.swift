//
//  main.swift
//  day04
//
//  Created by Tyler Kieft on 12/29/18.
//  Copyright © 2018 Tyler Kieft. All rights reserved.
//

import Foundation
import CommonCrypto

// From https://stackoverflow.com/questions/24123518/how-to-use-cc-md5-method-in-swift-language
extension String  {
    var md5: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deallocate()
        
        return String(format: hash as String)
    }
}

let SECRET_KEY = "yzbqklnj"

func findIntegerGeneratingMD5WithPrefix(prefix: String) -> Int {
    var i = 0
    
    while true {
        let input = SECRET_KEY + String(i);
        
        if autoreleasepool(invoking: { input.md5.starts(with: prefix) }) {
            return i
        }

        i += 1
    }
}

print(findIntegerGeneratingMD5WithPrefix(prefix: "00000"))
print(findIntegerGeneratingMD5WithPrefix(prefix: "000000"))
