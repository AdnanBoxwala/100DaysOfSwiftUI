import Cocoa

let numbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

func printLuckyNumbers(_ numbers: [Int]) {
    numbers.sorted().filter {
        $0 % 2 != 0
    }.map { number in
        print("\(number) is a lucky number")
    }
}

printLuckyNumbers(numbers)
