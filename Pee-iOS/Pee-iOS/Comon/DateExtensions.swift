//
//  DateExtensions.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/11.
//

import Foundation

extension Date {
    
    var hhmm: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    var MDotD: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateFormat = "M.d"
        return formatter.string(from: self)
    }
    
    var week: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateFormat = "EEE"
        return formatter.string(from: self)

    }
    
    
   static var startOfToday: Date {
        let calendar = Calendar.current
       return calendar.startOfDay(for: Date())
    }
    
   static var endOfToday: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: startOfToday) ?? Date()
    }
    
    var startOfToday: Date {
         let calendar = Calendar.current
        return calendar.startOfDay(for: self)
     }
     
    var endOfToday: Date {
         return Calendar.current.date(byAdding: .day, value: 1, to: startOfToday) ?? Date()
     }
    
    var formattedDuration: String {
        let intervals = Date().timeIntervalSince1970 - self.timeIntervalSince1970
       return RecordFormatter.formattedDuration(intervals)
    }
    
    static func <= (lhs: Self, rhs: Self) -> Bool {
        return lhs.timeIntervalSince1970 <= rhs.timeIntervalSince1970
    }
    
    static func >= (lhs: Self, rhs: Self) -> Bool {
        return lhs.timeIntervalSince1970 >= rhs.timeIntervalSince1970
    }
    
    static func > (lhs: Self, rhs: Self) -> Bool {
        return lhs.timeIntervalSince1970 > rhs.timeIntervalSince1970
    }
    
    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.timeIntervalSince1970 < rhs.timeIntervalSince1970
    }
}

struct RecordFormatter {
    
    static func formattedDuration(_ seconds: TimeInterval) -> String {
        let intervals = seconds
        let hours = Int(intervals / 3600)
        let minutes = Int(intervals.truncatingRemainder(dividingBy: 3600) / 60)
        var formattedDuration = ""
        switch true {
        case intervals < 3600 && intervals >= 60:
            formattedDuration = "\(minutes) " + "分钟"
        case intervals >= 3600 && intervals < 360_000:
            let hourStr = "\(hours) " + "小时"
            let minuteStr = String(format: "%02d", minutes) + "分钟"
            formattedDuration = hourStr + " " + minuteStr
        default:
            formattedDuration = "\(Int(intervals))" + "秒"
        }
        
        return formattedDuration
    }
}
