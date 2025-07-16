//
//  HeatMapViewModel.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/16.
//

import Foundation

struct HeatDay {
    let id = UUID()
    let date: Date
    let level: Int
}

class HeatMapViewModel: ObservableObject {
    @Published var weekdays: [String] = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"]
    @Published var columns: [[HeatDay]] = []

    
    init() {
        let calendar = Calendar.current
        var dateComponent = DateComponents()
        dateComponent.year = 2025
        dateComponent.month = 1
        let startDate = calendar.date(from: dateComponent)!
        
        dateComponent.month = 12
        let endDate = calendar.date(from: dateComponent)!
        
        columns = generateHeatMap(from: startDate, to: endDate)
    }
    
    func generateHeatMap(from startDate: Date, to endDate: Date) -> [[ HeatDay]] {
        var calendar = Calendar.current
        calendar.firstWeekday = 1
        
        var date = startDate
        var columns: [[HeatDay]] = []
        var currentColumn: [HeatDay] = []
        while date <= endDate {
            let weekday = calendar.component(.weekday, from: date)
            if weekday == calendar.firstWeekday && !currentColumn.isEmpty {
                columns.append(currentColumn)
                currentColumn = []
            }
            currentColumn.append(HeatDay(date: date, level: Int.random(in: 0..<4)))
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        }
        
        if !currentColumn.isEmpty {
            columns.append(currentColumn)
        }
        return columns
    }
}
    
