import UIKit

struct UserLocationData {
    let latitude: Double
    let longitude: Double
    let updatedCount: Int
    let time: Date
}

// Keys for DataBase
struct DataBaseKeys {
    static let longitudeKey = "longitude"
    static let latitudeKey = "latitude"
    static let locationTable = "Location"
    static let time = "time"
}

// Keys for userDefault
struct LocalKeys {
    static let uploadCount = "uploadCount"
    static let day = "day"
}
