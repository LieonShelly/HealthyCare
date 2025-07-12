//
//  Record.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/10.
//

import SwiftData
import RealmSwift
import Foundation

class Record: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var date: Date
    @Persisted var amount: Double
    @Persisted var duration: Double
    @Persisted var color: Int?
    @Persisted var comfortDegress: Int?
    @Persisted var presureDegress: Int?
    @Persisted var note: String?
    
    override init() {
        super.init()
    }
    
    
    func update(
        id: UUID = UUID(),
        date: Date,
        amount: Double,
        duration: Double,
        color: Int? = nil,
        comfortDegress: Int? = nil,
        presureDegress: Int? = nil,
        note: String? = nil
    ) {
        self.date = date
        self.amount = amount
        self.duration = duration
        self.color = color
        self.comfortDegress = comfortDegress
        self.presureDegress = presureDegress
        self.note = note
        self.id = id
    }
}
