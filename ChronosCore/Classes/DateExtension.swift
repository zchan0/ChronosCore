//
//  DateExtension.swift
//  ChronosSwift
//
//  Created by Cencen Zheng on 2018/7/24.
//

public extension Date {
    static func + (lhs: Date, rhs: Measurement<UnitDuration>) -> Date? {
        let afterSeconds: TimeInterval = rhs.converted(to: UnitDuration.seconds).value
        return date(byAddingSeconds: Int(afterSeconds), toDate: lhs)
    }
    static func + (lhs: Measurement<UnitDuration>, rhs: Date) -> Date? {
        let afterSeconds: TimeInterval = lhs.converted(to: UnitDuration.seconds).value
        return date(byAddingSeconds: Int(afterSeconds), toDate: rhs)
    }
    static func - (lhs: Date, rhs: Measurement<UnitDuration>) -> Date? {
        let beforeSeconds: TimeInterval = rhs.converted(to: UnitDuration.seconds).value
        return date(byAddingSeconds: -Int(beforeSeconds), toDate: lhs)
    }
    
    static func date(byAddingSeconds seconds: Int,
                     toDate date: Date,
                     withCalendar calendar: Calendar = Calendar.current) -> Date? {
        return calendar.date(byAdding: .second, value: seconds, to: date)
    }
    
    struct FormatterCache {
        static let shared: NSCache = NSCache<NSString, DateFormatter>()
    }
    ///
    ///
    /// - Parameters:
    ///   - dateString:
    ///   - fmt: for the formatter.dateFormat, default value is "yyyy-MM-dd HH:mm",
    ///   - calendar: for the formatter.calendar, default value is Calendar.current
    /// - Returns: Date?
    static func dateFromString(_ dateString: String,
                               withFormatter fmt: String = "yyyy-MM-dd HH:mm",
                               withCalendar calendar: Calendar = Calendar.current) -> Date? {
        var formatter = FormatterCache.shared.object(forKey: fmt as NSString)
        if formatter == nil {
            formatter = DateFormatter()
            formatter!.dateFormat = fmt
            formatter!.calendar = calendar
            formatter!.timeZone = formatter!.calendar.timeZone
            FormatterCache.shared.setObject(formatter!, forKey: fmt as NSString)
        }
        
        return formatter!.date(from: dateString)
    }
    
    
    /// convert Date to String with DateFormatter
    ///
    /// - Parameters:
    ///   - date:
    ///   - fmt: for the formatter.dateFormat, default value is "yyyy-MM-dd"
    ///   - calendar: for the formatter.calendar, default value is Calendar.current
    /// - Returns: String
    static func stringFromDate(_ date: Date,
                               withFormatter fmt: String = "yyyy-MM-dd",
                               withCalendar calendar: Calendar = Calendar.current) -> String {
        var formatter = FormatterCache.shared.object(forKey: fmt as NSString)
        if formatter == nil {
            formatter = DateFormatter()
            formatter!.dateFormat = fmt
            formatter!.calendar = calendar
            formatter!.timeZone = formatter!.calendar.timeZone
            FormatterCache.shared.setObject(formatter!, forKey: fmt as NSString)
        }
        
        return formatter!.string(from: date)
    }
}

public extension Calendar {
    /// this approach works for other calendar units by specifying a different `NSCalendarUnit` value for the `ordinalityOfUnit:` parameter.
    /// for example, you can calculate the number of years based on the number of times Jan 1, 12:00 AM is present between.
    ///
    /// - Parameters:
    ///   - startDate:
    ///   - endDate:
    /// - Returns: Number of midnights
    func numberOfMidnights(ofStartDate startDate: Date, _ endDate: Date) -> Int {
        if let startDay = self.ordinality(of: .day, in: .era, for: startDate),
            let endDay = self.ordinality(of: .day, in: .era, for: endDate) {
            return endDay - startDay
        }
        return 0
    }
    
    /// the difference between `numberOfDays:` and `numberOfMidnights` is that the previous one regards >24h as a day
    /// for example, try "2010-01-14 23:30" and "2010-01-15 08:00" and the result is 0
    ///
    /// - Parameters:
    ///   - startDate:
    ///   - endDate:
    /// - Returns: Number of days(more than 24h)
    func numberOfDays(ofStartDate startDate: Date, _ endDate: Date) -> Int? {
        return self.dateComponents([.day], from: startDate, to: endDate).day
    }
    
    /// check when a date falls
    ///     credits: https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtCalendricalCalculations.html#//apple_ref/doc/uid/TP40007836-SW9
    ///
    /// - Parameter date:
    /// - Returns: true of false
    func isDateInWeek(_ date: Date) -> Bool {
        var startDate: NSDate?
        var extends: TimeInterval = 0
        let today = Date()
        
        let success = (self as NSCalendar).range(of: .weekOfMonth, start: &startDate, interval: &extends, for: today)
        if !success {
            return false
        }
        
        let dateInSecs = date.timeIntervalSinceReferenceDate
        let dayStartInSecs = startDate!.timeIntervalSinceReferenceDate
        return dateInSecs > dayStartInSecs && dateInSecs < (dayStartInSecs + extends)
    }
    
    /// suppose `self` is a Gregorian calendar
    ///
    /// - Parameter date: default value is today(Date())
    /// - Returns: the beginning of this week
    func beginningOfWeek(ofDate date: Date = Date()) -> Date? {
        // Get the weekday component of the current date
        let weekdayComponents = self.component(.weekday, from: date)
        
        /*
         Create a date components to represent the number of days to subtract from the current date.
         The weekday value for Sunday in the Gregorian calendar is 1, so subtract 1 from the number of days to subtract from the date in question.
         If today is Sunday, subtract 0 days.
         */
        var componentsToSubtract = DateComponents()
        componentsToSubtract.day = 0 - (weekdayComponents - 1)
        
        return self.date(byAdding: componentsToSubtract, to: date)
    }
}
