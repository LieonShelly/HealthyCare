//
//  RecordViewModel.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/10.
//

import Combine
import SwiftData
import Foundation

final class RecordViewModel: ObservableObject {
    let repository: RecordRepository
    @Published var isLoading: Bool = false
    @Published var showLoading: Bool = false
    init(repository: RecordRepository) {
        self.repository = repository
    }
    
    @MainActor
    func addTestData(context: ModelContext) {
        logThread()
        for _ in (0 ..< 1000) {
            let record = Record(date: Date.now, amount: 200, duration: 15)
            try? repository.add(record: record, context: context)
        }
    }
    
    func logThread() {
        print(Thread.current)
    }
    
    func fetch(context: ModelContext) async {
        
       await MainActor.run {
            isLoading = true
           showLoading = true
        }
        guard let _ = try? await self.repository.fetchRecods(context: context) else { return }
        await MainActor.run {
            isLoading = false
            showLoading = false
        }
        
       
    }
    
}

