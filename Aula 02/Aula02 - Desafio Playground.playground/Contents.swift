import UIKit

class Stack<T: Any> {
    let capacity : Int
    var top : Int
    var elems : [T?]
    
    init(_ capacity: Int) {
        self.capacity = capacity
        top = -1
        elems = []
        
        for _ in 0..<capacity {
            elems.append(nil)
        }
    }
    
    func push(element : T) {
        if top + 1 < capacity {
            top += 1
            elems[top] = element
            print("Pushing new element: \(element)")
        }
        else {
            print("Can't push new element (\(element)), stack is already full.")
        }
    }
    
    func pop() -> T? {
        if top >= 0 {
            print("Popping top element.")
            top -= 1
            return elems[top + 1]
        }
        else {
            print ("Stack is empty")
            return nil
        }
    }
    
    func isEmpty() -> Bool {
        return top < 0
    }
    
    func isFull() -> Bool {
        return top == capacity - 1
    }
}

var newStack = Stack<String>(5)

print("Is the Stack empty? \(newStack.isEmpty())")
newStack.pop()
newStack.push(element: "Test 1")
print("Stack top element was: \(newStack.pop() ?? "nil")")
newStack.push(element: "Test 2")
newStack.push(element: "Test 3")
newStack.push(element: "Test 4")
print("Is the Stack full? \(newStack.isFull())")
print("Is the Stack empty? \(newStack.isEmpty())")
newStack.push(element: "Test 5")
newStack.push(element: "Test 6")
print("Is the Stack full? \(newStack.isFull())")
newStack.push(element: "Teste 7")
print("Stack top element was: \(newStack.pop() ?? "nil")")
newStack.push(element: "Teste 8")
// newStack.push(element: 9) <-- Throws an error

