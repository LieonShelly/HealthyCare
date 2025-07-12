//
//  RecordCoordinator.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/12.
//


import SwiftUI

class RecordCoordinator: ObservableObject, Coordinator {
    @Published var path = NavigationPath()
    @Published var modal: RecordRoute? = nil
    
    func push(_ route: any Route) {
        guard let route = route as? RecordRoute else { return }
        switch route {
        case let .recording(record):
            path.append(RecordRoute.recording(record))
        case .recordList:
            path.append(RecordRoute.recordList)
        }
    }
    
    func present(_ route: any Route) {
        guard let route = route as? RecordRoute else { return  }
        modal = route
    }
    
    func dismiss() {
        modal = nil
    }
    
    func view(for route: any Route) -> AnyView {
        guard let route = route as? RecordRoute else { return AnyView(EmptyView()) }
        switch route {
        case .recordList:
            return AnyView(RecordListView(viewModel: RecordListViewModel(repository: RecordRepository())))
        case let .recording(record):
            let viewModel = RecordViewModel(repository: .init())
            if let record {
                viewModel.update(record)
            }
            return AnyView(RecordingView(viewModel: RecordViewModel( repository: .init())))
        }
    }
}
