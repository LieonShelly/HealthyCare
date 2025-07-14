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
        let now = Date.endOfToday
        let calendar = Calendar.current
        guard let pastSevenDay = calendar.date(byAdding: .day, value: -7, to: now) else { return [] }
        let records = try await repository.fetchRecods(from: pastSevenDay, to: pastSevenDay)
        var frequencies: [Frequency] = []
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
