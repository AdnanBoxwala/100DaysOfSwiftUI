import Cocoa

enum NumberError: Error{
    case outOfBounds, noRoot
}

func squareRoot(of number: Int) throws -> Int{
    if number < 1 || number > 10_000 {
        throw NumberError.outOfBounds
    }
    
    for i in 1...100 {
        if number == i * i {
            return i
        }
    }
    throw NumberError.noRoot
}

//let number = 1_000_000
//let number = 169
let number = 50
do {
    let result = try squareRoot(of: number)
    print("Square root of \(number) is \(result)")
} catch NumberError.outOfBounds {
    print("\(number) out of bounds.")
} catch NumberError.noRoot {
    print("Could not find a square root for \(number).")
}

