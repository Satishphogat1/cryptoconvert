import Foundation

public enum Regex: String {

    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    case number = "^[0-9]+$"
    var pattern: String {
        return rawValue
    }
}

public extension String {

    public func match(_ pattern: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: characters.count)) != nil
        } catch {
            return false
        }
    }
}
