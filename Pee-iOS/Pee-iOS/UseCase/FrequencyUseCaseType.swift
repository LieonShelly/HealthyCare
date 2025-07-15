//
//  FrequencyUseCaseType.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/14.
//

import Foundation

protocol FrequencyUseCaseType {
    func execute() async throws -> [Frequency]
}

final class FrequencyUseCase: FrequencyUseCaseType {
    private let repository: RecordRepositoryType
    
    init(repository: RecordRepositoryType) {
        self.repository = repository
    }
    
    func execute() async throws -> [Frequency] {
        var now = Date.endOfToday
        let calendar = Calendar.current
        guard let pastSevenDay = calendar.date(byAdding: .day, value: -7, to: now) else { return [] }
        let records = try await repository.fetchRecords(from: pastSevenDay, to: now)
        var frequencies: [Frequency] = []
        now = Date()
        for index in (0 ..< 7) {
            guard let today = calendar.date(byAdding: .day, value: -index, to: now) else { continue }
            let startOfToday = today.startOfToday
            let endOfToday = today.endOfToday
            
            let count = records.filter({ $0.date > startOfToday && $0.date < endOfToday }).count
            frequencies.append(Frequency(times: count, date: startOfToday))
        }
        return frequencies
    }
}


struct AverageInterval {
    var interval: Double
    let date: Date
}



protocol AverageIntervalUseCaseType {
    func execute() async throws -> [AverageInterval]
}


final class AverageIntervalUseCase: AverageIntervalUseCaseType {
    private let repository: RecordRepositoryType
    
    init(repository: RecordRepositoryType) {
        self.repository = repository
    }
    
    func execute() async throws -> [AverageInterval] {
        let now = Date.endOfToday
        let calendar = Calendar.current
        guard let pastSevenDay = calendar.date(byAdding: .day, value: -7, to: now) else { return [] }
        let records = try await repository.fetchRecords(from: pastSevenDay, to: now)
        var results: [AverageInterval] = []
        for index in (0 ..< 7) {
            guard let today = calendar.date(byAdding: .day, value: -index, to: now) else { continue }
            let startOfToday = today.startOfToday
            let endOfToday = today.endOfToday
            
            let todayRecords = records.filter({ $0.date > startOfToday && $0.date < endOfToday })
            let intervals = (0 ..< todayRecords.count - 1).map { index in
                return todayRecords[index + 1].date.timeIntervalSince1970 - todayRecords[index].date.timeIntervalSince1970
            }
            let sum = intervals.reduce(0, { $0 + $1 })
            let averageInveral =  sum / Double(intervals.count)
            results.append(AverageInterval(interval: averageInveral, date: today))
        }
        return results
    }
}
