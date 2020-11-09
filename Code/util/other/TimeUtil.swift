//
//  TimeUtil.swift
//  Tmp
//
//  Created by Gleb Shendrik on 06.07.2020.
//

import Foundation

class TimeUtil {
    
    static var shared = TimeUtil()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        return formatter
    }()
    
    private lazy var isoFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
    
    enum FormattedTimeFormat: String {
        case MESSAGE = "EEE, MMM d"
        case HISTORY = "yyyy-MM-dd"
        case HISTORY_DETAILS = "yyyy-MM-dd HH:mm:ss"
        case HISTORY_TEXT = "d MMM, E"
    }
    
    func dateFromIsoString(_ string: String?) -> Date? {
        guard let string = string else { return nil }
        return self.isoFormatter.date(from: string)
    }
        
    func formateDateToString(_ date: Date?, _ format: FormattedTimeFormat) -> String {
        guard let date = date else { return "" }
        self.dateFormatter.dateFormat = format.rawValue
        return self.dateFormatter.string(from: date)
    }
    
    func dateFromString(_ string: String?, _ format: FormattedTimeFormat) -> Date? {
        guard let string = string else { return nil }
        self.dateFormatter.dateFormat = format.rawValue
        return dateFormatter.date(from: string)
    }
}

protocol Dated {
    var date: Date { get }
}

extension Array where Element: Dated {
    func groupedBy(dateComponents: Set<Calendar.Component>) -> [Date: [Element]] {
        let initial: [Date: [Element]] = [:]
        let groupedByDateComponents = reduce(into: initial) { acc, cur in
            let components = Calendar.current.dateComponents(dateComponents, from: cur.date)
            let date = Calendar.current.date(from: components)!
            let existing = acc[date] ?? []
            acc[date] = existing + [cur]
        }
        
        var fixed: [Date: [Element]] = [:]
        
        groupedByDateComponents.forEach { (key, data) in
            fixed[data.first!.date] = data
        }
        
        return fixed
    }
}
