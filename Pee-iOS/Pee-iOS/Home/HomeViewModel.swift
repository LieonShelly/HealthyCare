//
//  HomeViewModel.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/14.
//

import Foundation

class HomeViewModel: ObservableObject {
    @MainActor @Published var times: Int = 0
    @MainActor @Published var amount: Int = 0
    @MainActor @Published var timesInNight: Int = 0
    @MainActor @Published var averageIntervals: String = "0分"
    @MainActor @Published var sinceLastTime: String = "0分"
    let frequencyViewModel: FrequencyViewModel
    
    private let service: UrineServiceful
    
    init(service: UrineServiceful) {
        self.service = service
        self.frequencyViewModel = FrequencyViewModel(service: service)
    }
    
    func fetchData() async throws {
        let amount =  try await service.todayAmountUseCase.execute()
        let times =  try await service.todayTimesUseCase.execute()
        let averageIntervals =  try await service.todayAverageIntervalUseCase.execute()
        let sinceLastTime = try await service.lastTimeUseCase.execute()
        try await frequencyViewModel.fetchData()
        await MainActor.run {
            self.amount = amount
            self.times = times
            self.averageIntervals = RecordFormatter.formattedDuration(averageIntervals)
            self.sinceLastTime = sinceLastTime.formattedDuration
        }
    }
    
    
}
