//
//  TodayTimesUseCaseType.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/14.
//

import Foundation

protocol TodayTimesUseCaseType {
    func execute() async throws ->  Int
}

final class TodayTimesUseCase: TodayTimesUseCaseType {
    private let repository: RecordRepositoryType
    
    init(repository: RecordRepositoryType) {
        self.repository = repository
    }
    
    func execute() async throws -> Int {
        let records = try await repository.fetchRecords(from: .startOfToday, to: .endOfToday)
        return records.count
    }
}

