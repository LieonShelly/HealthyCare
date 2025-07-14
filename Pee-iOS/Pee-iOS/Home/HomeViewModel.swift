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
    @MainActor @Published var frequencies: [Frequency] = []
    
    private let service: UrineServiceful
    
    init(service: UrineServiceful) {
        self.service = service
    }
    
    func fetchData() async throws {

        await MainActor.run {
            let now = Date.endOfToday
            let calendar = Calendar.current
            guard let pastSevenDay = calendar.date(byAdding: .day, value: -7, to: now) else { return }
            var initFrequencies: [Frequency] = []
            for index in (0 ..< 7) {
                guard let today = calendar.date(byAdding: .day, value: -index, to: now) else { continue }
                let startOfToday = today.startOfToday
                initFrequencies.append(Frequency(times: 0, date: startOfToday))
            }
            self.frequencies = initFrequencies
        }
        
        let amount =  try await service.todayAmountUseCase.execute()
        let times =  try await service.todayTimesUseCase.execute()
        let averageIntervals =  try await service.todayAverageIntervalUseCase.execute()
        let sinceLastTime = try await service.lastTimeUseCase.execute()
        let frequencies = try await service.frequencies.execute()
       
        await MainActor.run {
            self.amount = amount
            self.times = times
            self.averageIntervals = RecordFormatter.formattedDuration(averageIntervals)
            self.sinceLastTime = sinceLastTime.formattedDuration
            self.frequencies = frequencies
        }
    }
    
    
}
