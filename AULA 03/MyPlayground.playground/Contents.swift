import UIKit

var notasA : [Double] = [ 10, 6, 8, 3, 7]
var notasB : [Double] = [ 5, 2, 9, 10, 6]

// Sort
notasA = notasA.sorted(by: <)
print(notasA)

// Map
notasA = notasA.map { $0 / 2 }
print(notasA)

// Filter
notasA = notasA.filter { $0 >= 3 }
print(notasA)

// Reducer
var soma = notasA.reduce(0, +)
print(soma)
