import Cocoa

func getRandomNumber(from numbers: [Int]?) -> Int {
    return numbers?.randomElement() ?? Int.random(in: 1...100)
}

let firstRandomNumber = getRandomNumber(from: [101, 102, 103, 104])
print("First random number: \(firstRandomNumber)")

let secondRandomNumber = getRandomNumber(from: nil)
print("Second random number: \(secondRandomNumber)")
