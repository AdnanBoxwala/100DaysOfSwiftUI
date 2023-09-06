import Cocoa

class Animal {
    let legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    func speak() {
        print("A dog barks.")
    }
}

class Cat: Animal {
    let isTame: Bool
    
    init(legs: Int, isTame:Bool) {
        self.isTame = isTame
        super.init(legs: legs)
    }
    
    func speak() {
        print("A cat meows.")
    }
}

final class Corgi: Dog {
    override func speak() {
        print("A corgi also barks.")
    }
}

final class Poodle: Dog {
    override func speak() {
        print("A poodle also barks.")
    }
}

final class Persian: Cat {
    override func speak() {
        print("A persian also meows.")
    }
}

final class Lion: Cat {
    override func speak() {
        print("A Lion roars.")
    }
}

let myDog = Dog(legs: 4)
myDog.speak()
let myCat = Cat(legs: 4, isTame: true)
myCat.speak()

print("")
      
let myCorgi = Corgi(legs: 4)
print("A corgi has \(myCorgi.legs) legs.")
myCorgi.speak()

print("")
            
let myPoodle = Poodle(legs: 4)
print("A poodle has \(myPoodle.legs) legs.")
myPoodle.speak()

print("")
        
let myPersian = Persian(legs: 4, isTame: true)
print("A persian has \(myPersian.legs) legs.")
print(myPersian.isTame ? "A persian can be tamed." : "A persian cannot be tamed.")
myPersian.speak()

print("")
        
let myLion = Lion(legs: 4, isTame: false)
print("A lion has \(myLion.legs) legs.")
print(myLion.isTame ? "A lion can be tamed." : "A lion cannot be tamed.")
myLion.speak()
