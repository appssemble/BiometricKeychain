//
//  BioDataExtension.swift
//  BIOKeychainTest
//
//  Created by Dragos Dobrean on 28/06/2019.
//  Copyright © 2019 APPSSEMBLE-SOFT. All rights reserved.
//

import Foundation

extension Data {
    
    init<T>(from value: T) {
        self = Swift.withUnsafeBytes(of: value) { Data($0) }
    }
    
    func to<T>(type: T.Type) -> T? where T: ExpressibleByIntegerLiteral {
        var value: T = 0
        guard count >= MemoryLayout.size(ofValue: value) else { return nil }
        _ = Swift.withUnsafeMutableBytes(of: &value, { copyBytes(to: $0)} )
        return value
    }
}
