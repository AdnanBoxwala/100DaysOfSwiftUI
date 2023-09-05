import Cocoa

struct Car {
    let modelName: String
    let numberOfSeats: Int
    private var currentGear: Int {
        didSet {
            print("Shifted to gear \(currentGear).")
        }
    }
    
    enum shiftDirection {
        case up, down
    }
    
    init(name: String, seatCount: Int) {
        modelName = name
        numberOfSeats = seatCount
        currentGear = 1
    }
    
    mutating func shiftGear(_ direction: shiftDirection) {
        switch direction {
        case .up:
            if currentGear + 1 > 10 {
                print("Cannot shift up further!")
            } else {
                currentGear += 1
            }
        case .down:
            if currentGear - 1 < 1 {
                print("Cannot shift down further!")
            } else {
                currentGear -= 1
            }
        }
    }
}

var myCar = Car(name: "Audi TT", seatCount: 2)
myCar.shiftGear(.up)
myCar.shiftGear(.up)
myCar.shiftGear(.up)
myCar.shiftGear(.down)



