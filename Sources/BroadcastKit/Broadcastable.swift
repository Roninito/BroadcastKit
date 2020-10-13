//
//  Broadcastable.swift
//  Stardust
//
//  Created by leerie simpson on 5/5/20.
//  Copyright © 2020 leerie simpson. All rights reserved.
//

import Foundation


public protocol Broadcastable: RawRepresentable, ExpressibleByStringLiteral, Hashable {
    var rawValue: String { get set }
    
    init(_ value: String)
    init(rawValue: String)
    init(stringLiteral value: String)
    init(unicodeScalarLiteral value: String)
    init(extendedGraphemeClusterLiteral value: String)
}


public extension Broadcastable {
    init(_ value: String) { self.init(rawValue: value) }
    init(rawValue: String) { self.init(rawValue) }
    init(stringLiteral value: String) { self.init(value) }
    init(unicodeScalarLiteral value: String) { self.init(value) }
    init(extendedGraphemeClusterLiteral value: String) { self.init(value) }
}
