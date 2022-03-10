import UIKit

// Class 03 Challange - Palindrome

func isPalindrome(_ word : String) -> Bool {
    
    // Goes through each letter in the word and move it to the beginning of a temporary word (initially empty), adding to the previous iteration
    let wordReverse : String = word.reduce("", { letterA, letterB in
        String(letterB) + String(letterA)
    })
    
    return word.lowercased() == wordReverse.lowercased()
    // lowercased() is used to avoid case sensitive errors
}

let wordA = "Teste"
let wordB = "Radar"

print("Is the word \"\(wordA)\" Palindrome? \(isPalindrome(wordA) ? "Yes" : "No")")
print("Is the word \"\(wordB)\" Palindrome? \(isPalindrome(wordB) ? "Yes" : "No")")
