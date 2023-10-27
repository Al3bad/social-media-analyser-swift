import Foundation

class Parser {
    static func parseStr(str: String?) throws -> String {
        guard let str = str else {
            throw ParseValueError.withMessage(message: "Invalid Value! Value cannot be empty")
        }
        let strTrimmed = str.trimmingCharacters(in: .whitespacesAndNewlines)
        if strTrimmed.count == 0 {
            throw ParseValueError.withMessage(message: "Invalid Value! Value cannot be empty")
        }
        return strTrimmed
    }

    static func parseInt(str: String?, min: Int) throws -> Int {
        guard let str = str else {
            throw ParseValueError.withMessage(message: "Invalid integer!")
        }

        guard let parsedValue = Int(str) else {
            throw ParseValueError.withMessage(message: "Invalid integer!")
        }

        if parsedValue < min {
            throw ParseValueError.withMessage(message: "Integer must be equal or greater than \(min - 1)")
        }

        return parsedValue
    }

    static func parseDateTime(str: String?, format: String) throws -> String {
        guard let str = str else {
            throw ParseValueError.withMessage(message: "Invalid dateTime!")
        }

        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.current
        guard let _ = formatter.date(from: str) else {
            throw ParseValueError.withMessage(message: "Invalid format! Date/Time must be in this format: \(format)")
        }
        return try parseStr(str: str)
    }

    static func parseCSV(str: String, expectedFields: Int) throws -> [String] {
        let strTrimmed = str.trimmingCharacters(in: .whitespacesAndNewlines)
        var fields = strTrimmed.components(separatedBy: ",")
        if fields.count != expectedFields {
            throw ParseValueError.withMessage(message: "Invalid line! Expected \(expectedFields) but got \(fields.count)")
        }
        for i in 0..<fields.count {
            fields[i] = fields[i].trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return fields
    }
}
