import Foundation

class CoronaClass {
    
    var seats = [Int]()
    var place: Int
    
    init(n: Int) {
        place = n
    }
    
    func leave(_ p: Int) {
        if let index = seats.firstIndex(of: p) {
            seats.remove(at: index)
        }
    }
    
    func seat() -> Int  {
        var tempSeat = 0
        var seatsIndex = 0
        var studentsSeat = 0
        
        if seats.first != 0 {
            studentsSeat = 0
            seats.insert(studentsSeat, at: 0)
            
        } else if seats.last != place - 1 && seats.count < 2 {
            studentsSeat = place - 1
            seats.append(place - 1)
            
        } else {
            for i in 1 ..< seats.count {
                if (seats[i] - seats[i - 1]) / 2 > tempSeat {
                    tempSeat = (seats[i] - seats[i - 1]) / 2
                    seatsIndex = i
                    studentsSeat = seats[i - 1] + tempSeat
                }
            }
            
            if seats.last != place - 1 {
                if place - 1 - seats.last! > tempSeat {
                    studentsSeat = place - 1
                    seats.append(place - 1)
                    return studentsSeat
                }
            }
            seats.insert(studentsSeat, at: seatsIndex)
        }
        return studentsSeat
    }
}
