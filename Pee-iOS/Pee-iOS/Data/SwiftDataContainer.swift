//
//  SwiftDataContainer.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/11.
//

import SwiftData
import Foundation

final class SwiftDataContainer {
    static let shared: SwiftDataContainer = .init()
    private(set) var container: ModelContainer!
    
    private init() {
        let schema = Schema([Record.self])
        let appGroupURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "com.renjun.Pee-iOS")
        let storeURL = appGroupURL?.appendingPathComponent("peedatabse.sqilte")
        let config = ModelConfiguration(
            "peedatabse",
            schema: schema,
            url: storeURL!
        )
        self.container = try? ModelContainer(
            for: schema,
            configurations: [config]
        )
    }
}
