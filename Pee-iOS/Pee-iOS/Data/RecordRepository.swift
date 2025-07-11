//
//  RecordRepository.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/10.
//

import SwiftData
import RealmSwift

@MainActor
class RecordRepository: @unchecked Sendable {
    
    func fetchRecods(
        context: ModelContext,
        predicate: Predicate<Record>? = nil,
        sort: [SortDescriptor<Record>] = []
    ) async throws -> [RecordModel] {
        let dataTask: Task<[RecordModel], any Error> =  Task.detached {
            var decscriptor = FetchDescriptor<Record>(predicate: predicate, sortBy: sort)
            decscriptor.fetchLimit = 20
            let data = try context.fetch(decscriptor)
                .map {
                    RecordModel(id: $0.id,
                                date: $0.date,
                                amount: $0.amount,
                                duration: $0.duration,
                                color: $0.color,
                                comfortDegress: $0.comfortDegress,
                                presureDegress: $0.presureDegress,
                                note: $0.note)
                }
            return data
        }
        return try await dataTask.value
    }
    
    func add(record: Record, context: ModelContext) throws {
        context.insert(record)
        try context.save()
       
    }
    
    func syncAdd(_ record: Record) throws {
        let context = ModelContext(SwiftDataContainer.shared.container)
        context.insert(record)
        try context.save()
    }
}
