import Cocoa

protocol Building {
    var numberOfRooms: Int { get }
    var cost: Int { get set }
    var estateAgentName: String { get }
    
    func showSalesSummary()
}

extension Building {
    func showSalesSummary() {
        print(
        """
        Object type: \(Self.self)
            - number of rooms: \(numberOfRooms)
            - name of estate agent: \(estateAgentName)
            - price: \(cost)
        """)
    }
}

struct House: Building {
    let numberOfRooms: Int
    var cost: Int
    let estateAgentName: String
}

struct Office: Building {
    let numberOfRooms: Int
    var cost: Int
    let estateAgentName: String
}

var house = House(numberOfRooms: 3, cost: 250_000, estateAgentName: "Taylor Swift")
house.showSalesSummary()

var office = Office(numberOfRooms: 7, cost: 1_000_000, estateAgentName: "Mark Zuckerberg")
office.cost = 1_200_000
office.showSalesSummary()
