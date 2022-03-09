//
//  main.swift
//  Learning
//
//  Created by Aloc FL00030 on 07/03/22.
//

import Foundation

var optionalString: String? = "Hello"
print(optionalString == nil)
// Prints "false"

var optionalName: String? = "John Appleseed"
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
}
