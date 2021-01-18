import Foundation

extension Date {
    func convertToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy HH:mm:ss"
        formatter.timeZone = TimeZone.current
        let date = formatter.string(from: self)
        return date
    }
}
