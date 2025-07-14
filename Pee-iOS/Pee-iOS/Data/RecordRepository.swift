//
//  RecordRepository.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/10.
//

import RealmSwift
import Foundation

protocol RecordRepositoryType {
    func fetchRecords(from: Date, to: Date) async throws -> [RecordModel]
}

class RecordRepository: RecordRepositoryType {
    
    func fetchRecords(from: Date = .startOfToday, to: Date = .endOfToday) async throws -> [RecordModel] {
        let dataTask: Task<[RecordModel], any Error> = Task.detached {
            logThread()
            let realm = try Realm()
            let data = realm.objects(Record.self)
                .where { $0.date >= from && $0.date < to }
                .sorted(by: { $0.date > $1.date })
                .map {
                    RecordModel(id: $0.id,
                                date: $0.date,
                                amount: $0.amount,
                                duration: $0.duration,
                                color: ColorDegree(rawValue: $0.color ?? 0) ?? .normal,
                                comfortDegress: ComfortDegree(rawValue: $0.comfortDegress ?? 0) ?? .normal,
                                presureDegress: PresureDegree(rawValue: $0.presureDegress ?? 0) ?? .normal,
                                note: $0.note)
                }
            return data.map { $0 }
        }
        return try await dataTask.value
    }
    
    func add(record: RecordModel) async throws {
        let dataTask: Task<Void, any Error> = Task.detached {
            logThread()
            let realm = try Realm()
            let data = Record()
            
            data.update(id: record.id,
                        date: record.date,
                        amount: record.amount,
                        duration: record.duration,
                        color: record.color.rawValue,
                        comfortDegress: record.comfortDegress.rawValue,
                        presureDegress: record.presureDegress.rawValue,
                        note: record.note)
            try realm.write {
                realm.add(data, update: .modified)
            }
            return
        }
        return try await dataTask.value
    }

}

func logThread() {
    print(Thread.current)
}
