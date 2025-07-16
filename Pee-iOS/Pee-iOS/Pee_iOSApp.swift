//
//  Pee_iOSApp.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/9.
//

import SwiftUI

@main
struct Pee_iOSApp: App {
    @StateObject private var coordinator = RecordCoordinator(service: UrineService(respository: RecordRepository()))
    
    var body: some Scene {
        WindowGroup {
            HeatMapView()
                .padding()
        }
        .environmentObject(coordinator)
    }
}
