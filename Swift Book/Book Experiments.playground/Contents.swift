import UIKit
import Foundation

// Funcion as a parameter
func hasAnyMatches(numbers : [Int], condition : (Int) -> Bool) -> Bool {
    for item in numbers {
        let result = condition(item)
        print(result)
        if result {
            return true
        }
    }
    
    return false
}

func lessThanTen(number : Int) -> Bool {
    print (number)
    return number < 10
}

let result = lessThanTen(number: 9) || lessThanTen(number: 8)

// Enums and Structs

enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king

    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

enum Suit {
    case spades, hearts, diamonds, clubs
    
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
    
    
    func color() -> UIColor {
        switch self {
        case .spades, .clubs:
            return UIColor.black
        case .hearts, .diamonds:
            return UIColor.red
        }
    }
     
}

struct Card {
    var suit : Suit
    var rank : Rank
    
    func simpleDescription() -> String {
        return "\(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
    
    init(rank: Rank, suit: Suit) {
        self.rank = rank
        self.suit = suit
    }
}

func allCards() -> [Card] {
    let suits = [Suit.hearts, Suit.spades, Suit.clubs, Suit.diamonds]
    var cards : [Card] = []
    
    for rankValue in 1...13 {
        for suit in suits {
            if let rank = Rank(rawValue: rankValue) {
                let card = Card(rank: rank, suit: suit)
                cards.append(card)
            }
        }
    }
    
    return cards
}

let cards = allCards()

for card in cards {
    print(card.simpleDescription())
}

// Protocols

protocol DescriptionProtocol {
    var description : String { get }
    mutating func adjust()
}

extension Int : DescriptionProtocol {
    var description : String {
        return "The number \(self)"
    }
    
    mutating func adjust() {
        self += 42
    }
}

print (8.description)
var number = 10
number.adjust()
print (number)

// Error Handling

enum PrinterError : Error {
    case outOfPaper
    case noToner
    case broken
}

func sendToPrint(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Impressora Quebrada" {
        throw PrinterError.broken
    }
    
    return "Trabalho \(job) enviado."
}

do {
    try print(sendToPrint(job: 2, toPrinter: "Impressora Boa"))
    try print(sendToPrint(job: 3, toPrinter: "Impressora Quebrada"))
}
catch PrinterError.broken {
    print("Impressora quebrada, envio cancelado")
}

// Defer

class Chest {
    var isOpen : Bool = false
    var name : String
    let coinsGain = 10
    
    init(name: String) {
        self.name = name
    }
    
    func openChestAndCollect(coins : Int) -> Int {
        isOpen = true
        defer {
            isOpen = false
        }
        
        if isOpen {
            return coins + coinsGain
        }
        else {
            return coins
        }
    }
}

var chest = Chest(name: "Teste")

var currentCoins = 10
currentCoins = chest.openChestAndCollect(coins: currentCoins)
print(currentCoins)

// Generics

func makeArray<Item>(baseItem: Item, _ numberOfTimes : Int) -> [Item] {
    var result : [Item] = []
    for _ in 0..<numberOfTimes {
        result.append(baseItem)
    }
    
    return result
}

print(makeArray(baseItem: "Teste", 4))
