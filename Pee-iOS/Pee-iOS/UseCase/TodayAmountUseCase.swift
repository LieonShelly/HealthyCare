//
//  TodayAmountUseCase.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/14.
//

import Foundation

protocol TodayAmountUseCaseType {
    func execute() async throws ->  Int
}

final class TodayAmountUseCase: TodayAmountUseCaseType {
    private let repository: RecordRepositoryType
    
    init(repository: RecordRepositoryType) {
        self.repository = repository
    }
    
    func execute() async throws -> Int {
        let records = try await repository.fetchRecords(from: .startOfToday, to: .endOfToday)
        return records.reduce(0) { partialResult, record in
            return Int(partialResult + Int(record.amount))
        }
    }
}

