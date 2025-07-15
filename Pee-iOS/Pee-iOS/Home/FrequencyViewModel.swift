//
//  FrequencyViewModel.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/15.
//

import Foundation

class FrequencyViewModel: ObservableObject {
    @MainActor @Published var frequencies: [Frequency] = []
    
    private let service: UrineServiceful
    
    init(service: UrineServiceful) {
        self.service = service
    }
    
    func fetchData() async throws {
        await MainActor.run {
            let now = Date()
            let calendar = Calendar.current
            var initFrequencies: [Frequency] = []
            for index in (0 ..< 7) {
                guard let today = calendar.date(byAdding: .day, value: -index, to: now) else { continue }
                let startOfToday = today.startOfToday
                initFrequencies.append(Frequency(times: 0, date: startOfToday))
            }
            self.frequencies = initFrequencies
        }
        
        let frequencies = try await service.frequencies.execute()
        
        await MainActor.run {
            self.frequencies = frequencies
        }
    }
}
