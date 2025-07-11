//
//  RecordModel.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/11.
//

import Foundation

struct RecordModel: Sendable, Identifiable {
    var id: UUID
    var date: Date
    var amount: Double
    var duration: Double
    var color: Int?
    var comfortDegress: Int?
    var presureDegress: Int?
    var note: String?
    
    init(
        id: UUID,
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
