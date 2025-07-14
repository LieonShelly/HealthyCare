//
//  TodayPerIntervalUseCaseType.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/14.
//

import Foundation

protocol TodayAverageIntervalUseCaseType {
    func execute() async throws -> Double
}

final class TodayAverageIntervalUseCase: TodayAverageIntervalUseCaseType {
    private let repository: RecordRepositoryType
    
    init(repository: RecordRepositoryType) {
        self.repository = repository
    }
    
    func execute() async throws -> Double {
        let records = try await repository.fetchRecods(from: .startOfToday, to: .endOfToday).sorted(by: { $0.date < $1.date})
        guard records.count > 1 else {
            return 0
        }
        let intervals = (0 ..< records.count - 1).map { index in
            return records[index + 1].date.timeIntervalSince1970 - records[index].date.timeIntervalSince1970
        }
        let sum = intervals.reduce(0, { $0 + $1 })
        return sum / Double(intervals.count)
    }
}
