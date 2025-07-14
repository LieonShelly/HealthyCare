//
//  SinceLastTimeUseCaseType.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/14.
//

import Foundation

protocol SinceLastTimeUseCaseType {
    func execute() async throws -> Date
}

final class SinceLastTimeUseCase: SinceLastTimeUseCaseType {
    private let repository: RecordRepositoryType
    
    init(repository: RecordRepositoryType) {
        self.repository = repository
    }
    
    func execute() async throws -> Date {
        let record = try await repository.fetchRecords(from: .startOfToday, to: .endOfToday).first
        guard let record else { return Date() }
       return record.date
    }
}

