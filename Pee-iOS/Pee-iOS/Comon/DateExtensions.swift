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
    
   static var startOfToday: Date {
        let calendar = Calendar.current
       return calendar.startOfDay(for: Date())
    }
    
   static var endOfToday: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: startOfToday) ?? Date()
    }
}
