//
//  Frequency.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/14.
//

import Foundation

struct Frequency: Sendable, Equatable, Identifiable {
    var id: UUID = UUID()
    
    var times: Int
    let date: Date
}

