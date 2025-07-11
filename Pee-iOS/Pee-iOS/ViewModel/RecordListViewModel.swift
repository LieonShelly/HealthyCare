//
//  RecordListViewModel.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/11.
//

import Combine
import SwiftData
import Foundation

final class RecordListViewModel: ObservableObject {
    @MainActor @Published var isLoading: Bool = false
    @MainActor @Published var list: [RecordModel] = []
    
    let repository: RecordRepository
    
    init(repository: RecordRepository) {
        self.repository = repository
    }
    
//    func fetch() async {
//        await  MainActor.run {
//            isLoading = true
//        }
//        guard let list = try? await self.repository.fetchRecods() else { return }
//        
//        await  MainActor.run {
//            isLoading = false
//            self.list = list
//        }
//    }
}
