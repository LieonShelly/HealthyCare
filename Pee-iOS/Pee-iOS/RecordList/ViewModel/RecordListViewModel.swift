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
    @Published var showDetail: Bool = false
    
    let repository: RecordRepository
    
    init(repository: RecordRepository) {
        self.repository = repository
    }
    
    func fetch() async throws {
        await  MainActor.run {
            isLoading = true
        }
        let list = try await self.repository.fetchRecords()
        await  MainActor.run {
            isLoading = false
            self.list = list
        }
    }
}

