//
//  RecordModel.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/11.
//

import Foundation

enum PresureDegree: Int, Sendable {
    case normal = 0
    case light
    case medium
    case severe
    
    var desc: String {
        switch self {
        case .normal:
            "正常"
        case .light:
            "轻度"
        case .medium:
            "中度"
        case .severe:
            "重度"
        }
    }
}

enum ColorDegree: Int, Sendable {
    case normal = 0
    case light
    case medium
    case severe
    
    var desc: String {
        switch self {
        case .normal:
            "正常"
        case .light:
            "淡黄"
        case .medium:
            "黄色"
        case .severe:
            "黄红"
        }
    }
}

enum ComfortDegree: Int, Sendable {
    case normal = 0
    case light
    case medium
    case severe
    case extraSevere
    
    var desc: String {
        switch self {
        case .normal:
            "正常"
        case .light:
            "尿急"
        case .medium:
            "微痛"
        case .severe:
            "灼热"
        case .extraSevere:
            "残尿感"
        }
    }
}


struct RecordModel: Sendable, Identifiable, Equatable, Hashable {
    var id: UUID
    var date: Date
    var amount: Double
    var duration: Double
    var color: ColorDegree = .normal
    var comfortDegress: ComfortDegree = .normal
    var presureDegress: PresureDegree = .normal
    var note: String?
    
    init(
        id: UUID = UUID(),
        date: Date,
        amount: Double,
        duration: Double,
        color: ColorDegree = .normal,
        comfortDegress: ComfortDegree = .normal,
        presureDegress: PresureDegree = .normal,
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
