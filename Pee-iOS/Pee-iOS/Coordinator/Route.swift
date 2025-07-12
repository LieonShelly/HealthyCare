//
//  Route.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/12.
//

import SwiftUI

protocol Route: Hashable, Identifiable { }

enum RecordRoute: Route {
    var id: UUID {
        UUID()
    }
    case recording(_ record: RecordModel?)
    case recordList
}

protocol Coordinator {
    func push(_ route: any Route)
    func present(_ route: any Route)
    func dismiss()
    
    
    func view(for route: any Route) -> AnyView
}
