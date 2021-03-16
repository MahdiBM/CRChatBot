import Vapor

extension UserRequests {
    struct Public: Content {
        var username: String
        var date: String
        var description: String
        
        init(_ userRequest: UserRequests, addingTimeInterval interval: Int) {
            let date = Date(timeIntervalSince1970: .init(userRequest.timestamp))
            let dateStr = date.addingTimeInterval(.init(interval)).description
            
            self.username = userRequest.username
            self.date = dateStr.removing(" +0000")
            self.description = userRequest.description
        }
    }
}

extension UserRequests {
    func convertToPublic(addingTimeInterval interval: Int = 0) -> Public {
        .init(self, addingTimeInterval: interval)
    }
}
